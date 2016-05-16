#!/usr/bin/env ruby

# <bitbar.title>Hacker News</bitbar.title>
# <bitbar.author>Joe Canero</bitbar.author>
# <bitbar.author.github>caneroj1</bitbar.author.github>
# <bitbar.image>https://i.imgur.com/bghlATz.png</bitbar.image>

require 'net/http'
require 'json'
# require 'pp'

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
    .gsub('second','2nd')
    .gsub('Fourth','4th')
    .gsub('Libraries','Libs')
    .gsub('library','lib')
    .gsub('Hacker News','HN')
    .gsub('Project','Proj')
    .gsub('asynchronous','async')
    .gsub(' and ',' & ')
    .gsub('with','w/')
    .gsub('memory','mem')
    .gsub('Facebook','FB')
    .gsub('JavaScript','JS')
    .gsub('iPhone','📱 ')
    .gsub('phone','📱 ')
    .gsub('average','avg')
    .gsub('size','sz')
    .gsub('Japan','🇯🇵 ')
    .gsub('Bitcoin','BTC')
    .gsub('Tesla','TSLA')
    .gsub('year-old','yo')
    .gsub('Global','🌎 ')
    .gsub('World','🌎 ')
    .gsub('"','')
    .gsub('“','')
    .gsub('”','')
    .gsub('Announcing','📢 ')
end

def domain(url)
  require 'pp'
  m = url.match /^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/
  return url if  m.nil?
  m[3].to_s
    .gsub('www.', '')
    .gsub('.com','')
end

def output(story)
  begin
    u = story["url"]
    puts "#{story["title"]} — #{domain(u)} | href=#{u} color=#337ab7"
    puts "#{u} | href=#{u} color=#cccccc"
    puts "Comments: #{story["descendants"]} | href=https://news.ycombinator.com/item?id=#{story["id"]} color=black"
    puts "Score: #{story["score"]} | color=#{interpolate(story["score"])}"
  rescue => exception
    puts "An error occured: " + exception.to_s
    # puts story
  end
  puts output_separator
end

def output_main(story)
  s = shorten story["title"]
  d = domain story['url']

  o = s
  o << '\n'
  o << "#{d.upcase} 💬 #{story["descendants"]} | color=orange size=9"
  puts o
  puts output_separator
end

def output_separator
  '---'
end

begin
  get_top_stories(1).map { |id| get_story_for_id(id) }.each { |story| output_main story }
  get_top_stories(NUMBER_OF_STORIES).map { |id| get_story_for_id(id) }.each { |story| output(story) }
rescue => _
  puts "Content is currently unavailable. Please try resetting. | color=red"
end
