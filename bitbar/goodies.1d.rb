#!/usr/bin/env ruby

require 'ios_goodies_new_issue'

web = IosGoodiesNewIssue::web_get()
next_issue = web.to_i + 1
github = IosGoodiesNewIssue::github_matches(next_issue)
output = github ? '💖\n‼️' : '💖\n✅'
output << " | size=8"
puts output
puts '---'
puts "Current issue: Week #{web} | href=http://ios-goodies.com/"
puts '---'
puts "#{IosGoodiesNewIssue::VERSION}"
