require "octokit"
require "pp"

client = Octokit::Client.new(access_token: ENV["CUSTOM_BUILD_CI_API_TOKEN"])
pp client.user
repository_uri = URI(ENV["BUILDKITE_REPO"])
repository = repository_uri.path[1..-5]
pp repository
client.create_status(repository, ENV["BUILDKITE_COMMIT"], "pending", { 
  :context => "CI/Pinterest", 
  :target_url => ENV["BUILDKITE_BUILD_URL"], 
  :description => "Building…"
})