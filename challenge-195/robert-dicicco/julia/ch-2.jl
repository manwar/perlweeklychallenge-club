Challenge 195 Most Frequent Even ( Julia )

#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2022-12-14

Challenge 195 Most Frequent Even ( Julia )

 

SAMPLE OUTPUT

julia .\MFE.jl

Input: @list = [1, 1, 2, 6, 2]

Output: 2

 

Input: @list = [1, 3, 5, 7]

Output: -1

 

Input: @list = [6, 4, 4, 6, 1]

Output: 4

-------------------------------------------------

=#

using Printf

 

nn = [[1,1,2,6,2], [1,3,5,7], [6,4,4,6,1]]

 

for n in nn

  seen = Dict()

  @printf("Input: @list = %s\n", n )

  for x in n

    if (x % 2 == 0) && (x > 1)

      (haskey(seen,x)) ? (seen[x] += 1) : (seen[x] = 1)

    end

  end

  if length(seen) > 0

    val = first(sort(collect(seen), by = x->x[1]))

    @printf("Output: %d\n\n",val[1])

  else

    println("Output: -1\n")

  end

end
