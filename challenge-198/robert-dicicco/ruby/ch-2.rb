#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-01-02

Challenge 198 Prime Count ( Ruby )

=end

 

require 'prime'

arr = [10,15,1,25]

 

arr.each do |n|

                cnt = 0

                puts("Input: $n = #{n}")

                for x in 0..n-1 do

                                if Prime.prime?(x)  #=> true

                                                cnt += 1

                                end

                end

                puts("Output: #{cnt}")

                puts(" ")

end

 

=begin

ruby .\PrimeCount.rb

Input: $n = 10

Output: 4

 

Input: $n = 15

Output: 6

 

Input: $n = 1

Output: 0

 

Input: $n = 25

Output: 9

 

=end
