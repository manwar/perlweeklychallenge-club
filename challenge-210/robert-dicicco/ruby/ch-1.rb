#!/usr/bin/env ruby
=begin
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-28
Challenge 210 Kill&Win ( Ruby )
--------------------------------------
=end

myint =[[2,3,1],[1,1,2,2,2,3]]
$total_score = 0;
$max_score = 0;
$max_possible = 0;

def Score(arr)
    arr.each do |testx|
    testx = testx.to_i
        puts("trying #{testx}")
        arr.each do |val|
        val = val.to_i
            $total_score += val if ((val == testx) || (val == testx-1) || (val == testx+1))
        end
        if ($total_score == $max_possible)
            puts("Output: #{$total_score}")
            puts("")
            return
        end
        if $total_score > $max_score
            $max_score = $total_score
        end
        $total_score = 0
    end
    puts("Output: #{$max_score}\n")
    puts("")
end

myint.each do |a|
    puts("Input: @int = #{a}")
    $max_possible = a.sum
    puts("max possible = #{$max_possible}")
    Score(a)
end

=begin
--------------------------------------
SAMPLE OUTPUT
ruby .\KillWin.rb
Input: @int = [2, 3, 1]
max possible = 6
trying 2
Output: 6

Input: @int = [1, 1, 2, 2, 2, 3]
max possible = 11
trying 1
trying 1
trying 2
Output: 11
--------------------------------------
=end


