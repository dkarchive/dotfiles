#!/usr/bin/env ruby

require 'date'

DATE = 'may 20 2016 10am'
EVENT = '家庭日'

d = DateTime.parse DATE
# puts d.strftime "%d/%m/%Y %H:%M"

now = DateTime.now
# puts now.strftime "%d/%m/%Y %H:%M"

d = (d - now).to_i

puts "🗓#{d}d to #{EVENT}"
