#!/usr/bin/env ruby

# <bitbar.title>Hacker News</bitbar.title>
# <bitbar.author>Joe Canero</bitbar.author>
# <bitbar.author.github>caneroj1</bitbar.author.github>
# <bitbar.image>https://i.imgur.com/bghlATz.png</bitbar.image>

require 'net/http'
require 'json'

NUMBER_OF_STORIES = 5
MAX_SCORE = 300

def get_top_stories(num)
  url = "https://hacker-news.firebaseio.com/v0/topstories.json"
  JSON.parse(Net::HTTP.get(URI(url)))[0...num]
end

def get_story_for_id(id)
  url = "https://hacker-news.firebaseio.com/v0/item/#{id}.json?"
  JSON.parse(Net::HTTP.get(URI(url)))
end

def conv(val)
  (val / MAX_SCORE.to_f * 255).to_i
end

def interpolate(score)
  red = conv(MAX_SCORE - [score, MAX_SCORE].min)
  green = conv([score, MAX_SCORE].min)
  "#%02X%02X%02X" % [red, green, 0]
end

def shorten(story)
  story.gsub('The ','- ')
    .gsub('the ','- ')
    .gsub('first','1st')
    .gsub('Fourth','4th')
    .gsub(' to ',' 2 ')
    .gsub('Libraries','Libs')
    .gsub('library','lib')
    .gsub('Hacker News','HN')
    .gsub('Project','Proj')
    .gsub('asynchronous','async')
    .gsub('and','&')
    .gsub('with','w/')
    .gsub('memory','mem')
    .gsub('Facebook','FB')
    .gsub('JavaScript','JS')
    .gsub('iPhone','📱')
    .gsub('average','avg')
    .gsub('size','sz')
    .gsub('Japan','🇯🇵 ')
end

def output(story, redirect=true)
  begin
    puts redirect == false ? "#{shorten story["title"]} 💬#{story["descendants"]} | color=orange": "#{story["title"]} | href=#{story["url"]} color=#337ab7"
    puts "Comments: #{story["descendants"]} | href=https://news.ycombinator.com/item?id=#{story["id"]} color=black" if redirect
    puts "Score: #{story["score"]} | color=#{interpolate(story["score"])}" if redirect
  rescue => exception
    puts "An error occured: " + exception.to_s
  end
  puts "---"
end

begin
  get_top_stories(1).map { |id| get_story_for_id(id) }.each { |story| output(story, false) }
  get_top_stories(NUMBER_OF_STORIES).map { |id| get_story_for_id(id) }.each { |story| output(story) }
rescue => _
  puts "Content is currently unavailable. Please try resetting. | color=red"
end
