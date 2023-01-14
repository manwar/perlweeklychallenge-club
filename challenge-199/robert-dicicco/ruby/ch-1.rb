#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2023-01-09

Challenge 199 Good Pairs ( Ruby )

=end

 

 

lists = [[1,2,3,1,1,3],[1,2,3],[1,1,1,1]]

finalCnt = 0

 

lists.each do |list|

                puts "Input: @list = #{list}"

                beginner = 0

                ender = list.length() - 1

                cnt = beginner + 1

                while beginner < ender

                                while cnt <= ender

                                                if (list[cnt] == list[beginner]) then

                                                                puts("#{beginner},#{cnt}")

                                                                finalCnt += 1

                                                end

                                                cnt += 1

                                end

                                beginner += 1

                                cnt = beginner + 1

                end

                puts("Output: #{finalCnt}")

                puts(" ")

                finalCnt = 0

end

 

=begin

SAMPLE OUTPUT

ruby .\GoodPairs.rb

Input: @list = [1, 2, 3, 1, 1, 3]

0,3

0,4

2,5

3,4

Output: 4

 

Input: @list = [1, 2, 3]

Output: 0

 

Input: @list = [1, 1, 1, 1]

0,1

0,2

0,3

1,2

1,3

2,3

Output: 6

=end
