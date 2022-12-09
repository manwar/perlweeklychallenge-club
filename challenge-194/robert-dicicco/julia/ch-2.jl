#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE:   2022-12-06

Challenge 194 Frequency Equalizer ( Julia )

 

SAMPLE OUTPUT

julia .\FrequencyEqualizer.jl

Input: $s = 'abbc'

Output: 1

 

Input: $s = 'xyzyyxz'

Output: 1

 

Input: $s = 'xzxz'

Output: 0

=#

using Printf

 

ss = ["abbc", "xyzyyxz", "xzxz"]

x = 1

 

for s in ss

  global x

  seen = Dict()

  @printf("Input: \$s = \'%s\'\n", s)

  ln = length(s)

  while x <= ln

    zsub = SubString(s,x,x);

    haskey(seen,zsub) ? seen[zsub] += 1 : seen[zsub] = 1

    x += 1

  end

  highest = maximum(values(seen))

  lowest  = minimum(values(seen))

  lowest + 1 == highest ? println("Output: 1\n") : println("Output: 0\n")

  x = 1

end

 
