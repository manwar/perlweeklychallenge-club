#!/usr/bin/env ruby

def sort_string(s)
  h = Hash.new(0)
  s.split(' ').each do |e|
    e =~ /(\w+)(\d+)/
    h[$1] = $2
  end
  (h.keys.sort{|a,b| h[a] <=> h[b]}).join(' ')
end

puts sort_string('and2 Raku3 cousins5 Perl1 are4')
puts sort_string('guest6 Python1 most4 the3 popular5 is2 language7')
puts sort_string('Challenge3 The1 Weekly2')

