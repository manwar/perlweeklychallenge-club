#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 11-APR-2022
# Challenge 160 Four Is Magic ( Ruby )

require 'humanize'

n = ARGV[0].to_i
puts "Input \$n = #{n}"

while n != 4 do
  n_len = n.humanize.length
  print "#{n.humanize.capitalize} is #{n_len.humanize.capitalize}, ";
  n = n_len
end

puts "Four is magic."
