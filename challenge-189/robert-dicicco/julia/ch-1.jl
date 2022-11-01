#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-10-31

Challenge 189 Greater Character ( Julia )



You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array

lexicographically greater than the target character.

=#



using Printf



arr =  [["e", "m", "u", "g"], ["d", "c", "e", "f"], ["j","a","r"], ["d", "c", "a", "f"], ["t", "g", "a", "l"]]

target = ["b", "a", "o", "a", "v" ]



function TestValues( a, tv )

  @printf("Input: @array = %s, target = %s\n", a,tv)

  out = []

  for x in 1:length(a)

    if a[x] > tv

      push!(out, a[x])

    end

  end

  out = sort!(out)

  length(out) == 0 ? println(tv) : println(out[1])

  println(" ")

end



function main()

  cnt = 1      # arrays in julia are option base 1

  for a in arr

    TestValues(a, target[cnt])

    cnt += 1

  end

end



main()



#=

------------------------------------------

SAMPLE OUTPUT

PS G:\Projects\Perl\Challenges> julia .\GreaterChar.jl

Input: @array = ["e", "m", "u", "g"], target = b

e



Input: @array = ["d", "c", "e", "f"], target = a

c



Input: @array = ["j", "a", "r"], target = o

r



Input: @array = ["d", "c", "a", "f"], target = a

c



Input: @array = ["t", "g", "a", "l"], target = v

v

=#
