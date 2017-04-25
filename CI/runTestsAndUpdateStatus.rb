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

%x(./build_tmp.sh)

print "Build status: #{$CHILD_STATUS}"
if $CHILD_STATUS == 0
  update_status(client, "success", "All tests ran successfully.")
else
  update_status(client, "failure", "Tests failed.")
end