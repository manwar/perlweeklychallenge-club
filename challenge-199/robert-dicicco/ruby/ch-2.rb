#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-01-14

Challenge 199 Good Triplets ( Ruby )

=end

 

list = [3,0,1,1,9,7]

 

$x = 7

$y = 2

$z = 3

 

seen = Hash.new

 

list.permutation(3).to_a.each do |suba|

                if seen.has_key?(suba)

                                next

                else

                                seen[suba] = 1

                                x1 = list.find_index(suba[0])

                                x2 = list.find_index(suba[1])

                                x3 = list.find_index(suba[2])

                                if x1 > x2 || x2 > x3 || x1 > x3

                                                next

                                end

                                if (suba[0] - suba[1]).abs > $x || (suba[1] - suba[2]).abs > $y || (suba[0] - suba[2]).abs > $z

                                                next

                                else

                                                puts("#{suba}")

                                end

                end

end

 

=begin

SAMPLE OUTPUT

ruby .\GoodTriplets.rb

[3, 0, 1]

[3, 1, 1]

[0, 1, 1]

=end
