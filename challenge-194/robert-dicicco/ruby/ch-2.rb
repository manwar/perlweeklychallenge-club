#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE:   2022-12-06

Challenge 194 Frequency Equalizer ( Ruby )

 

SAMPLE OUTPUT

ruby .\FrequencyEqualizer.rb

Input: $s = 'abbc'

Output: 1

 

Input: $s = 'xyzyyxz'

Output: 1

 

Input: $s = 'xzxz'

Output: 0

=end

 

ss = ["abbc", "xyzyyxz", "xzxz"]

x = 0

seen = Hash.new

 

ss.each do |s|

  puts("Input: $s = \'#{s}\'")

  ln = s.length;

  while x < ln

    zsub = s[x,1]

    if seen.key?(zsub)

      seen[zsub] += 1

    else

      seen[zsub] = 1

    end

    if (x < ln)

      x += 1

    end

  end

  highest = seen.values.max

  lowest  =  seen.values.min

  lowest + 1 == highest ? puts("Output: 1") : puts("Output: 0")

  puts(" ")

  seen = Hash.new

  x = 0

end
