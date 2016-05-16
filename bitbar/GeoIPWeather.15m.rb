#!/usr/bin/env ruby
# coding: utf-8

# <bitbar.title>GeoIPWeather</bitbar.title>
# <bitbar.version>v0.1.1</bitbar.version>
# <bitbar.author>Taylor Zane</bitbar.author>
# <bitbar.author.github>taylorzane</bitbar.author.github>
# <bitbar.desc>Your weather in the menu bar 🌤</bitbar.desc>
# <bitbar.image>http://i.imgur.com/vrT6vfb.png</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/taylorzane</bitbar.abouturl>

### USER VARIABLES
UNITS = 'F' # This can be: (F)ahrenheit, (C)elsius, (K)elvin
API_KEY = '8b4824b451d5db1612156837df880f55' # you can also get your own at http://openweathermap.org/

require 'json'
require 'net/http'
require 'pp'

def no_data(message = nil)
  if message
    puts message
  else
    puts 'Cannot get weather.'
  end
  exit
end

def location
  location_uri = URI('http://ipinfo.io/json')

  location_data = Net::HTTP.get location_uri

  location_json = JSON.parse location_data

  zip = nil
  country = nil

  if location_json['postal']
    zip = location_json['postal']
  else
    no_data
  end

  if location_json['country']
    country = location_json['country']
  else
    no_data
  end

  [zip, country]
end

def weather_get_icon(condition)
  case condition
  when 800
    '☀️'
  when 801..804
    '☁️'
  when 300..321
    '🌧'
  when 500.504
    '🌦'
  when 200..232
    '⛈'
  when 521.531
  when 500..504
    '⛅'
  when 600..622
  when 511
    '🌨'
  when 781
  when 900..902
    '🌪'
  when 905
    '🌬'
  # when 'mist'
  #   '🌫'
  else
    ''
  end
end

def weather(zip_code, country)
  temperature_unit =
    case UNITS.upcase
    when 'F'
      '&units=imperial'
    when 'C'
      '&units=metric'
    else
      ''
    end

  temperature_symbol =
    case UNITS.upcase
    when 'F'
      '℉'
    when 'C'
      '℃'
    else
      'K'
    end

  weather_uri =
    URI('http://api.openweathermap.org/data/2.5/weather' \
        "?zip=#{zip_code},#{country}" \
        "&appid=#{API_KEY}" \
        "#{temperature_unit}")

  weather_data = Net::HTTP.get(weather_uri)

  no_data unless weather_data

  weather_json = JSON.parse weather_data

  no_data weather_json['message'] if weather_json['cod'] == '404'

  temperature = weather_json['main']['temp'].round

  city = weather_json['name']
  country = weather_json['sys']['country']

  weather_id = weather_json['weather'][0]['id']
  # puts weather_id.class
  # exit
  icon = weather_get_icon weather_id

  condition = weather_json['weather'][0]['description']

  puts "#{icon} #{temperature}"
  puts '---'
  puts condition.split.map(&:capitalize).join(' ')
  puts city
  pp weather_json
end

weather(*location)
