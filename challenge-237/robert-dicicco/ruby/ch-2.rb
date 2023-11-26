#!/usr/bin/env ruby
=begin
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-05
Challenge 237 Task 02 Maximise Greatness ( Ruby )
-----------------------------------------
=end

mynums = [[1, 3, 5, 2, 1, 3, 1], [1, 2, 3, 4]]

maxscore = 0;
score = 0;
output = [];

def CalcScore (a,b)
    cnt = 0;
    score = 0;
    while cnt < a.length()
        if a[cnt] < b[cnt]
            score += 1
        end
        cnt += 1
    end
    return score;
end

mynums.each do |nums|
    puts("Input: @nums = #{nums}")
    maxscore = 0;
    nums.permutation.to_a.each do |perm|
        score = 0
        score = CalcScore(nums, perm)
        ignore = (nums.length() / 2 + 1).floor()
        if score >= maxscore && score >= ignore
            maxscore = score
        end
    end
    puts("Output: #{maxscore}\n\n")
end

=begin
-----------------------------------------
SAMPLE OUTPUT
ruby .\MaximiseGreatness.rb

Input: @nums = [1, 3, 5, 2, 1, 3, 1]
Output: 4

Input: @nums = [1, 2, 3, 4]
Output: 3
-----------------------------------------
=end


