#!/usr/bin/env ruby
=begin
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-14
Challenge 234 Task 2 Unequal Triplets ( Ruby )
-----------------------------------
=end

myints = [[4, 4, 2, 4, 3],[1, 1, 1, 1, 1],[4, 7, 1, 10, 7, 4, 1, 1]]

myints.each do |mints|
    cnt = 0
    puts("input: @ints = #{mints}")
    ax = mints.combination(3).to_a
    ax.each do |res|
        if ((res[0] != res[1]) && (res[1] != res[2]) && (res[0] != res[2]))
            cnt += 1
        end
    end
    puts("#{cnt}\n\n")
end

=begin
-----------------------------------
SAMPLE OUTPUT
ruby .\UnequalTriplets.rb
input: @ints = [4, 4, 2, 4, 3]
3

input: @ints = [1, 1, 1, 1, 1]
0

input: @ints = [4, 7, 1, 10, 7, 4, 1, 1]
28
-----------------------------------
=end


