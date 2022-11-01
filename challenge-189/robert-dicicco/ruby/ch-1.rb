#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-10-31

Challenge 189 Greater Character ( Ruby )



You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array

lexicographically greater than the target character.

=end



$arr =  [["e", "m", "u", "g"], ["d", "c", "e", "f"], ["j","a","r"], ["d", "c", "a", "f"], ["t", "g", "a", "l"]]

$target = %w{b a o a v }



def TestValues (a, tv)

  print "Input: \@array = qw#{a}, target = #{tv}\n"

  out = []

  for x in 0..a.length() do

    if (a[x].to_s > tv.to_s )

      out.push(a[x].to_s)

    end

  end

  out.length() > 0 ? (puts "#{out.sort[0]}\n\n") : (puts "#{tv}\n\n")

end



def main()

  cnt = 0

  $arr.each do |a|

    TestValues(a, $target[cnt])

    cnt += 1

  end

end



main()



=begin

----------------------------------------------

SAMPLE OUTPUT

Input: @array = qw["e", "m", "u", "g"], target = b

e



Input: @array = qw["d", "c", "e", "f"], target = a

c



Input: @array = qw["j", "a", "r"], target = o

r



Input: @array = qw["d", "c", "a", "f"], target = a

c



Input: @array = qw["t", "g", "a", "l"], target = v

v

=end
