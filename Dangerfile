#DO NOT COMMIT
require 'pp'

source_pattern = /(\.m|\.mm|\.h)$/
  
# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"
has_changes_in_source_directory = !git.modified_files.grep(/Source/).empty?

modified_source_files = git.modified_files.grep(source_pattern)
has_modified_source_files = !modified_source_files.empty?
added_source_files = git.added_files.grep(source_pattern)
has_added_source_files = !added_source_files.empty?

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("This is a big PR, please consider splitting it up to ease code review.") if git.lines_of_code > 500

# Changelog entries are required for changes to source files.
no_changelog_entry = !git.modified_files.include?("CHANGELOG.md")
if has_changes_in_source_directory && no_changelog_entry && !declared_trivial
  fail("Any source code changes should have an entry in CHANGELOG.md or have #trivial in their title.")
end

def check_file_header(files_to_check, license)
  repo_name = github.pr_json["base"]["repo"]["full_name"]
  pr_number = github.pr_json["number"]
  files = github.api.pull_request_files(repo_name, pr_number)
  files.each do |file|
    if files_to_check.include?(file["filename"])
      filename = File.basename(file["filename"])
      license_header = <<-HEREDOC
//
      HEREDOC
      license_header += "//  " + filename + "\n"
      license_header += <<-HEREDOC
//  Texture
//
      HEREDOC
      license_header += license
    
      data = ""
      contents = github.api.get file["contents_url"]
      open(contents["download_url"]) { |io|
        data += io.read
      }
      if !data.start_with?(license_header)
        fail ("Please ensure new source files begin with: \n```" + license_header + "```")
      end
    end
  end
end

# Ensure new files have proper header
new_source_license_header = <<-HEREDOC
//  Copyright (c) 2017-present, Pinterest, Inc.  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//      http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
HEREDOC
if has_added_source_files
  check_file_header(added_source_files, new_source_license_header)
end

# Ensure modified files have proper header
modified_source_license_header = <<-HEREDOC
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//  Modifications to this file made after 4/13/2017 are: Copyright (c) 2017-present,
//  Pinterest, Inc.  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
HEREDOC
if has_modified_source_files
  check_file_header(modified_source_files, modified_source_license_header)
end