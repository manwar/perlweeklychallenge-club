#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-30

Challenge 193 Odd String ( Ruby )

 

You are given a list of strings of same length, @s.

 

Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.

 

Find the difference array for each string as shown in the example. Then pick the odd one out.

------------------------------------------------------------

SAMPLE OUTPUT

ruby .\OddString.rb

Input: ["adc", "wzy", "abc"]

Output: abc

 

Input: ["aaa", "bob", "ccc", "ddd"]

Output: bob

=end

 

ss = [["adc", "wzy", "abc"],["aaa", "bob", "ccc", "ddd"]]

 

$myout = []

 

def StringValue(s)

  v1 = s[1].ord - s[0].ord

  v2 = s[2].ord - s[1].ord

  saved = "#{v1},#{v2}"

  $myout.push(saved)

end

 

ss.each do |i|

  ln = i.length()             # i = ssubarray length

  puts("Input: #{i}")

  (0..ln-1).each do |x|

    StringValue(i[x])         # record value for each string

  end

 (0..i.length-1).each do |alen|

      c = $myout.count($myout[alen])

      if c == 1

        puts("Output: #{i[alen]}")

        break

      end

  end

  puts(" ")

  $myout = []

end
