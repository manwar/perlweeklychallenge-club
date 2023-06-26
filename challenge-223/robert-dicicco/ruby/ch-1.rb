#!/usr/bin/env ruby
=begin
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-26
Challenge 223 Task 1 Count Primes ( Ruby )
-----------------------------------------
=end
require 'prime'

input_n = [10,1,20];

input_n.each do |n|
    puts("Input: $n = #{n}")
    num = 0
    cnt = 0
    while num < n
        if(Prime.prime?(num))
            cnt += 1
        end
        num += 1
    end
    puts("Output: #{cnt}\n\n")
end

=begin
-----------------------------------------
SAMPLE OUTPUT
ruby .\CountPrimes.rb

Input: $n = 10
Output: 4

Input: $n = 1
Output: 0

Input: $n = 20
Output: 8
-----------------------------------------
=end


