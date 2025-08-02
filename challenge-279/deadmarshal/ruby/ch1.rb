#!/usr/bin/env ruby

def sort_letters(letters, numbers)
  h = Hash[letters.zip(numbers)]
  letters.sort_by{|k| h[k]}.join('')
end

puts sort_letters(['R','E','P','L'],[3,2,1,4])
puts sort_letters(['A','U','R','K'],[2,4,1,3])
puts sort_letters(['O','H','Y','N','P','T'],[5,4,2,6,1,3])

