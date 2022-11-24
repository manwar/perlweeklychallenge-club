#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-22

Challenge 192 Equal Distribution ( Ruby )

 

You are given a list of integers greater than or equal to zero, @list.

 

Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

 

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

 

1) You can only move a value of '1' per move

2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

 

SAMPLE OUTPUT

perl .\EqualDistribution.pl

Input: @lst = (1 0 5)

        1 1 4

        1 2 3

        1 3 2

        2 2 2

Output: 4

 

Input: @lst = (0 2 0)

Output: -1

 

Input: @lst = (0 3 0)

        1 2 0

        1 1 1

Output: 2

 

-----------------------------------------

SAMPLE OUTPUT

ruby .\EqualDistribution.rb

Input: @lst = [1, 0, 5]

        [1, 1, 4]

        [1, 2, 3]

        [1, 3, 2]

        [2, 2, 2]

Output: 4

 

Input: @lst = [0, 2, 0]

Output: -1

 

Input: @lst = [0, 3, 0]

        [1, 2, 0]

        [1, 1, 1]

Output: 2

-----------------------------------------

=end

 

lists = [[1,0,5],[0,2,0],[0,3,0]]

$cnt = 0

 

def MaxPos( arr )

  maxv = 0

  maxpos = -1

  for x in 0..2 do

    #puts "x = #{x}"

    if arr[x] > maxv

       maxv = arr[x]

       maxpos = x

    end

  end

  return maxv, maxpos

end

 

def MinPos( arr )

  minv = 9

  minpos = -1

  for x in 0..2 do

    if (arr[x] < minv)

      minv = arr[x]

      minpos = x

    end

  end

  return minv, minpos

end

 

def EvenUp(arr)

  $cnt += 1

  (maxv, maxpos) = MaxPos(arr)

  (minv, minpos) = MinPos(arr)

  puts "\t#{arr}" if ($cnt > 1);

  arr[maxpos] -= 1

  maxpos == 0 || maxpos == 2 ?(arr[1] += 1) : (arr[minpos] += 1)

  if ((arr[0] == arr[1])  && (arr[1] == arr[2]))

    puts "\t#{arr}"

    puts "Output: #{$cnt}"

    puts " "

  else

    EvenUp(arr)

  end

end

 

def GetTotalVal(arr)

  sum = 0

  (0..2).each { |x|

    sum += arr[x];

  }

  return sum

end

 

lists.each do |lst|

  puts "Input: \@lst = #{lst}";

  $cnt = 0

  target = (GetTotalVal(lst) / 3);

  target >= 1 ? EvenUp(lst) : (puts "Output: -1\n"; puts " ");

end
