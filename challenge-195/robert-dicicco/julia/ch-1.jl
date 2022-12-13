#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2022-12-13

Challenge 195 Special Integers ( Julia )

 

SAMPLE OUTPUT

julia .\SpecialIntegers.jl

Input: $n = 15

Output: 14

 

Input: $n = 35

Output: 32

----------------------------------------------------

=#

using Printf

 

narray = [15, 35]

 

function CheckUniqueDigits(n)

  seen = Dict()

  digs = digits(n)

  for onedig in digs

    if(haskey(seen,onedig))

      return 0

    else

      seen[onedig] = 1

    end

  end

  return 1

end

 

for n in narray

  println("Input: \$n = ", n)

  output = 0

  for nval = 1:n

    output += CheckUniqueDigits(nval)

  end

  @printf("Output: %d\n\n",output)

end
