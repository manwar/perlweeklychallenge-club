#!/usr/bin/env ruby

def split_string(str)
  str.count('aeiouy') % 2 == 0
end

puts split_string('perl')
puts split_string('book')
puts split_string('good morning')

