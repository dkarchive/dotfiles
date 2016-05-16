#!/usr/bin/env ruby

require 'date'

# User options
DATE = 'may 20 2016 10am'
EVENT = '家庭日'
FORMAT_SHORT = true
SYMBOL = '🗓'

d = DateTime.parse DATE
now = DateTime.now
d = (d - now).to_i

output = "#{d}d #{SYMBOL} #{EVENT}"

o = d.to_s
o << SYMBOL
o << '\n'
o << EVENT.to_s
o << ' | size=8'

puts FORMAT_SHORT ? o : output
puts '---'
puts output
