#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-10-24

Challenge 188 Divisible Pairs  ( Julia )



You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the following rules.



The pair (i, j) is eligible if and only if

a) 0 <= i < j < len(list)

b) list[i] + list[j] is divisible by k

=#



using Combinatorics

using Printf



arr = [[4, 5, 1, 6], [1, 2, 3, 4],[1, 3, 4 ,5], [5, 1, 2, 3], [7, 2, 4, 5]]

ks =[2,2,3,4,4]

cnt = 1

val = []



for ind in arr

  subcnt = 0

  @printf("Input: @list = %s, k = %d\n", ind, ks[cnt]) ;

  p = collect(permutations(ind,2))

  for subc in p

    i = subc[1]

    j = subc[2]

    k = ks[cnt]

    sz = length(ind)

    if ( (i < j) && ((i + j) % k == 0)  )

       subcnt += 1

    end

  end

  @printf("Output: %d\n\n",subcnt)

  subcnt = 0

  out = []

  global cnt += 1

end
