#!/usr/bin/env ruby
=begin
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-03
Challenge 215 Number Placement ( Ruby )
-----------------------------------------
=end

numbers = [[1,0,0,0,1],[1,0,0,0,1],[1,0,0,0,0,0,0,0,1]];
counts  = [1,2,3]

cnt = 0;

def CheckZeroes(arr)
    zcnt = 0;
    while zcnt < arr.length() - 1
        if ((arr[zcnt] == 0) && (arr[zcnt-1] == 0))
             arr[zcnt] = 1;
        end
        zcnt += 1;
    end
    puts("Output: 1 = #{arr}")
    puts("")
end


def HowManyZeroes(arr)
    z = 0
    zcnt = 0
    while z < (arr.length()) - 1
        if (arr[z] == 0)
            zcnt += 1
        end
        z += 1
    end
    return zcnt
end

numbers.each do |nums|
    puts("Input: @numbers = #{nums}")
    puts("Count: #{counts[cnt]}")
    cnt += 1
    zeroes = HowManyZeroes(nums)
    if (zeroes < cnt * 2)
        puts("Output: 0")
        puts("")
    else
        CheckZeroes(nums)
    end
end

=begin
-----------------------------------------
ruby .\NumberPlacement.rb
Input: @numbers = [1, 0, 0, 0, 1]
Count: 1
Output: 1 = [1, 0, 1, 0, 1]

Input: @numbers = [1, 0, 0, 0, 1]
Count: 2
Output: 0

Input: @numbers = [1, 0, 0, 0, 0, 0, 0, 0, 1]
Count: 3
Output: 1 = [1, 0, 1, 0, 1, 0, 1, 0, 1]
-----------------------------------------
=end


