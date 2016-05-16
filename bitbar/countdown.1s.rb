#!/usr/bin/env ruby

require 'date'

DATE = 'may 20 2016 10am'
EVENT = '家庭日'

d = DateTime.parse DATE
now = DateTime.now
d = (d - now).to_i

o = d.to_s
o << '🗓\n'
o << EVENT.to_s
o << ' | size=8'
puts o
