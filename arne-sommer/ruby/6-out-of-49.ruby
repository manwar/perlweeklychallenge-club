#! /usr/bin/env ruby

six = {}

while six.length < 6 do
  six[ rand(1...49) ] = 1
end

seven = [];

six.each do |key, value|
  seven.push key
end
  
seven.sort { |a,b| a <=> b }.each do |key|
  puts key
end
  
