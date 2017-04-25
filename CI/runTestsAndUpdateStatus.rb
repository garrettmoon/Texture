require "octokit"
# require "pp"

client = Octokit::Client.new(access_token: ENV["CUSTOM_BUILD_CI_API_TOKEN"])

def update_status(client, state, description)
  repository_uri = URI(ENV["BUILDKITE_REPO"])
  repository = repository_uri.path[1..-5]
  client.create_status(repository, ENV["BUILDKITE_COMMIT"], state, { 
    :context => "CI/Pinterest", 
    :target_url => ENV["BUILDKITE_BUILD_URL"], 
    :description => description
  })
end

update_status(client, "pending", "Building…")

log_path = "log.txt"

%x(./build_tmp.sh 2>&1|tee #{log_path})

puts "Build status: '#{$?}'"
if $? == 0
  update_status(client, "success", "All tests ran successfully.")
else
  if File.exist?(log_path)
    client.create_gist({
      :description => "Build log",
      :public => true,
      :files => {
        "log.txt" => {
          "content" => File.read(log_path)
        }
      }
    })
  end
  
  update_status(client, "failure", "Tests failed.")
  abort("Tests failed")
end