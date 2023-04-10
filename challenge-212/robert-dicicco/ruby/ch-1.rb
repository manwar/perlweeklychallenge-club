#!/usr/bin/env ruby
=begin
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-10
Challenge 212 Jumping Letters ( Ruby )
---------------------------------------
=end

word = 'Perl'
jump = [2,22,19,9]

#word = 'Raku'
#jump = [24,4,7,17]

alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

puts("Input: $word = #{word} and @jump = #{jump}")

print("Output: ")

for n in 0..word.length - 1 do
    ndx = alphabet.index(word[n].downcase) + jump[n]
    n == 0 ? (print alphabet[ndx % 26].upcase) : (print alphabet[ndx % 26])
end

=begin
---------------------------------------
SAMPLE OUTPUT
ruby .\Jumping.rb
Input: $word = Perl and @jump = [2, 22, 19, 9]
Output: Raku

ruby .\Jumping.rb
Input: $word = Raku and @jump = [24, 4, 7, 17]
Output: Perl
---------------------------------------
=end


