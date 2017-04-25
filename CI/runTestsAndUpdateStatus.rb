require "octokit"
require "pp"

client = Octokit::Client.new(access_token: ENV["CUSTOM_BUILD_CI_API_TOKEN"])
repo = "#{ENV["BUILDKITE_ORGANIZATION_SLUG"]}/#{ENV["BUILDKITE_PIPELINE_SLUG"]}"
client.create_status(repo, ENV["BUILDKITE_COMMIT"], "pending", { 
  :context => "CI/Pinterest", 
  :target_url => ENV["BUILDKITE_BUILD_URL"], 
  :description => "Building…"
})