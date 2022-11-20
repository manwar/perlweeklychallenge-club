#!/usr/bin/env julia

#=

UTHOR: Robert DiCicco

DATE: 2022-11-14

Challenge 191 Twice Largest ( Julia )



You are given list of integers, @list.

Write a script to find out whether the largest item in the

list is at least twice as large as each of the other items.

=#

using Printf



arr = [[1,2,3,4],[1,2,0,5],[2,6,3,1],[4,5,2,3]]



for lst in arr

  @printf("Input: @list = %s\n",lst);

  result = "good"

  max = maximum(lst)

  sort!(lst)

  x = 1

  while (x < length(lst))

    if ( (2 * (lst[x]) > max))

      println("Output: -1\n")

      result = "bad"

      break

    end

    x += 1

  end

  if (cmp(result,"good") == 0)

    println("Output: 1\n")

  end

end



#=

SAMPLE OUTPUT

Input: @list = [1, 2, 3, 4]

Output: -1



Input: @list = [1, 2, 0, 5]

Output: 1



Input: @list = [2, 6, 3, 1]

Output: 1



Input: @list = [4, 5, 2, 3]

Output: -1

=#
