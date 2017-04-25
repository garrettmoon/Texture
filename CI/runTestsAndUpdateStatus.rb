require "octokit"
require "pp"

client = Octokit::Client.new(access_token: ENV["CUSTOM_BUILD_CI_API_TOKEN"])
repository_uri = URI(ENV["BUILDKITE_REPO"])
repository = repository_uri.path[1..-5]

def update_status(client, repo, state, description)
  client.create_status(repo, ENV["BUILDKITE_COMMIT"], state, { 
    :context => "CI/Pinterest", 
    :target_url => ENV["BUILDKITE_BUILD_URL"], 
    :description => description
  })
end

update_status(client, repository, "pending", "Building…")

log_path = "log.txt"

log = %x(./build_tmp.sh)
puts log
File.write(log_path, log)

puts "Build status: '#{$?}'"
if $? == 0
  update_status(client, repository, "success", "All tests ran successfully.")
else
  if File.exist?(log_path)
    gist = client.create_gist({
      :description => "Build log",
      :public => true,
      :files => {
        "log.txt" => {
          "content" => File.read(log_path)
        }
      }
    })
    
    client.add_comment(repository, ENV["BUILDKITE_PULL_REQUEST"], "Build failed with [log](#{gist["files"][log_path]["raw_url"]})")
  end
  
  update_status(client, repository, "failure", "Tests failed.")
  abort("Tests failed")
end