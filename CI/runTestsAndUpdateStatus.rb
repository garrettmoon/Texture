require "octokit"
require "pp"

client = Octokit::Client.new(access_token: ENV["CUSTOM_BUILD_CI_API_TOKEN"])
repository_uri = URI(ENV["BUILDKITE_REPO"])
client.create_status(repository_uri.path[1..-1], ENV["BUILDKITE_COMMIT"], "pending", { 
  :context => "CI/Pinterest", 
  :target_url => ENV["BUILDKITE_BUILD_URL"], 
  :description => "Building…"
})