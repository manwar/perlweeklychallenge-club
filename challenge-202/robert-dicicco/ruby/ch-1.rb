#!usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-01-30

Challenge 202 Consecutive Odds ( Ruby )

=end



arrays = [[1,5,3,6],[2,6,3,5],[1,2,3,4],[2,3,5,7]]



arrays.each do |arr|

    check = ''

    puts("Input: @array = #{arr}")

    for x in 0..arr.count - 1

        arr[x] % 2 == 0 ? check = check + 'e' : check = check + 'o'

    end

    check.match('ooo') ? puts("Output: 1") : puts("Output: 0")

    puts()

end



=begin

SAMPLE OUTPUT

ruby .\ConsecutiveOdds.rb

Input: @array = [1, 5, 3, 6]

Output: 1



Input: @array = [2, 6, 3, 5]

Output: 0



Input: @array = [1, 2, 3, 4]

Output: 0



Input: @array = [2, 3, 5, 7]

Output: 1

=end
