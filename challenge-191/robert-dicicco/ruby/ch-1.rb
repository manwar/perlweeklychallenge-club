#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-14

Challenge 191 Twice Largest ( Ruby )



You are given list of integers, @list.

Write a script to find out whether the largest item in the

list is at least twice as large as each of the other items.

=end



arr = [[1,2,3,4],[1,2,0,5],[2,6,3,1],[4,5,2,3]]



arr.each do |lst|

  result = "good"

  print("Input: @list = #{lst}\n");

  max = lst.max()

  lst = lst.sort!

  x = 0

  while (x < lst.length()-1)

    if ( (2 * (lst[x]) > max))

      puts "Output: -1\n\n"

      result = "bad"

      break

    end

    x += 1

  end

  if (result.eql? "good")

    puts "Output: 1\n\n"

  end

end



=begin

SAMPLE OUTPUT

Input: @list = [1, 2, 3, 4]

Output: -1



Input: @list = [1, 2, 0, 5]

Output: 1



Input: @list = [2, 6, 3, 1]

Output: 1



Input: @list = [4, 5, 2, 3]

Output: -1

=end
