#!/usr/bin/env ruby

def reverse_string(s,e)
  idx = s.index(e)
  if idx.nil?
    return s
  end
  sub = s[0..idx]
  return sub.chars.sort.join + s[idx+1..-1]
end

puts reverse_string('challenge','e')
puts reverse_string('programming','a')
puts reverse_string('champion','b')

