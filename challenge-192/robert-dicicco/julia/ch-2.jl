#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-11-22

Challenge 192 Equal Distribution ( Julia )

 

You are given a list of integers greater than or equal to zero, @list.

 

Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

 

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

 

1) You can only move a value of '1' per move

2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

-----------------------------------------------

SAMPLE OUTPUT

julia .\EqualDistribution.jl

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

=#

 

using Printf

 

lists = [[1,0,5],[0,2,0],[0,3,0]]

cnt = 1

 

function MaxPos( arr )

  maxv = 0

  maxpos = -1

  for x in 1:3

    if arr[x] > maxv

       maxv = arr[x]

       maxpos = x

    end

  end

  return maxv, maxpos

end

 

function MinPos( arr )

  minv = 9

  minpos = -1

  for x in 1:3

    if (arr[x] < minv)

      minv = arr[x]

      minpos = x

    end

  end

  return minv, minpos

end

 

function GetTotalVal(arr)

  sum = 0

  for x in 1:3

    sum += arr[x];

  end

  return sum

end

 

function EvenUp(arr)

  global cnt += 1

  (maxv, maxpos) = MaxPos(arr)

  (minv, minpos) = MinPos(arr)

  if (cnt > 1);

  @printf("%s\n",arr)

 end

  arr[maxpos] -= 1

  if maxpos == 1 || maxpos == 3

      arr[2] += 1

  else

      arr[minpos] += 1

  end

  if ((arr[1] == arr[2])  &&  (arr[2] == arr[3]))

    @printf("%s\n",arr)

    @printf("Output: %d\n",cnt)

    println("\n")

  else

    EvenUp(arr)

  end

end

 

for lst in lists

  @printf("Input: @lst = %s\n", lst);

  global cnt = 0

  target = (GetTotalVal(lst) / 3)

  target >= 1 ? EvenUp(lst) : @printf("Output: -1\n\n");

end
