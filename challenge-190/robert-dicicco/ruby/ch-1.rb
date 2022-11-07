#!/usr/bin/envruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-07

Challenge 190 Capital Detection ( Ruby )



You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate

if it satisfies at least one of the following rules:



1) Only first letter is capital and all others are small.

2) Every letter is small.

3) Every letter is capital.



SAMPLE OUTPUT

Input: $s = "Perl"

Output: 1



Input: $s = "TPF"

Output: 3



Input: $s = "PyThon"

Output: 0



Input: $s = "raku"

Output: 2

=end



words = ["Perl", "TPF", "PyThon", "raku"]



words.each do |s|

  puts "Input: $s = \"#{s}\""

  if s.match(/^[A-Z][a-z]*$/)

      puts "Output: 1"

  elsif s.match(/^[a-z]*$/)

       puts "Output: 2"

  elsif s.match(/^[A-Z]*$/)

      puts "Output: 3"

  else

      puts "Output: 0"

  end

  puts " "

end
