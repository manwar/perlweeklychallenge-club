#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE  : 2022-12-26

Challenge 197 Move Zero ( Ruby )

=end

 

 

lists = [[1, 0, 3, 0, 0, 5],[1, 6, 4],[0, 1, 0, 2, 0]]

 

lists.each do |list|

                i = 0

                left = []

                right = []

                printf("Input: @list = %s\n",list)

                while i < list.length()

                                if list[i] > 0

                                                left.push(list[i])

                                else

                                                right.push(list[i])

                                end

                                i += 1

                end

                out = left + right

                puts("Output: (#{out}\n\n")

end

 

=begin

-------------------------------------------------------

SAMPLE OUTPUT

ruby .\MoveZero.rb

Input: @list = [1, 0, 3, 0, 0, 5]

Output: ([1, 3, 5, 0, 0, 0]

 

Input: @list = [1, 6, 4]

Output: ([1, 6, 4]

 

Input: @list = [0, 1, 0, 2, 0]

Output: ([1, 2, 0, 0, 0]

=end
