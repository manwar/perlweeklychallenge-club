#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-02-13

Challenge 204 Monotonic Array ( Raku )

=end



nums = [[1,2,2,3],[1,3,2],[6,5,5,4]]



def CheckIncreasing(arr,ln)

    cnt = 0

    while cnt < ln - 1

        arr[cnt + 1] >= arr[cnt] ? (cnt += 1) : (return 0)

    end

    return 1

end

 def CheckDecreasing(arr,ln)

    cnt = 0

    while cnt < ln - 1

        arr[cnt + 1] <= arr[cnt] ? (cnt += 1) : (return 0)

    end

    return 1

end



nums.each do |n|

    print("Input: \@nums = #{n}\n")

    len = n.length

    puts("0") if (CheckIncreasing(n,len) == 0) && (CheckDecreasing(n,len) == 0)

    puts("1") if (CheckIncreasing(n,len) == 1) || (CheckDecreasing(n,len) == 1)

end



=begin

ruby .\Monotones.rb

Input: @nums = [1, 2, 2, 3]

1

Input: @nums = [1, 3, 2]

0

Input: @nums = [6, 5, 5, 4]

1

=end
