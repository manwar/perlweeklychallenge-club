#!/usr/bin/env julia

#=

----------------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2022-12-20

Challenge 196 Pattern 132 ( Julia )

SAMPLE OUTPUT

julia .\Pattern132.jl

Input: @list = [3, 1, 4, 2]

Any[1, 4, 2]

 

Input: @list = [1, 2, 3, 4]

Output: -1

 

Input: @list = [1, 3, 2, 4, 6, 5]

Any[1, 3, 2]

 

Input: @list = [1, 3, 4, 2]

Any[1, 3, 2]

----------------------------------------------

=#

using Printf

 

lists = [[3, 1, 4, 2],[1, 2, 3, 4],[1, 3, 2, 4, 6, 5],[1, 3, 4, 2]]

out = []

 

function findFirst(list)

  for fi in 1:length(list)

    if list[fi] == 1

      push!(out, list[fi])

      return fi

    end

  end

end

 

function findSecond(list, fi)

  fi += 1

  while fi < length(list)

    if list[fi] >= 3

      push!(out, list[fi])

      return fi

    end

    fi += 1

  end

  return -1

end

 

function findThird(list, fi)

  fi += 1

  while fi <= length(list)

    if list[fi] in [1,2,3,4,5,6,7,8,9]

      if list[fi] < out[2]

        push!(out, list[fi])

      end

    end

    fi += 1

  end

  return -1

end

 

for list in lists

  global out

  out = []

  @printf("Input: @list = %s\n",list)

  retval = findFirst(list);

  secval = findSecond(list, retval)

  thirdval = findThird(list, secval)

  if length(out) == 3

    println(out)

  else

    println("Output: -1")

  end

  print("\n")

end
