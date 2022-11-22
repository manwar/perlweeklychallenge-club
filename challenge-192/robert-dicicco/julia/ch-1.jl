#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

  DATE: 2022-11-21

  Challenge 192 Binary Flip ( Julia )



  You are given a positive integer, $n.



  Write a script to find the binary flip.

  Example 1



  Input: $n = 5

  Output: 2



  First find the binary equivalent of the given integer, 101.

  Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.

  So Binary 010 => Decimal 2.

=#



using Printf

using Match



ns = [5,4,6]



for n in ns

  out = []

  @printf("\nInput: \$n = %d\n", n)

  binvals=string(n, base=2)

  for character in binvals

  @match character begin

     '1' => push!(out,'0')

     '0' => push!(out,'1')

     _   => println("Something else...")

    end

  end

  println(parse(Int, join(out); base=2))

end



#=

SAMPLE OUTPUT

julia .\BinaryFlip.jl



Input: $n = 5

2



Input: $n = 4

3



Input: $n = 6

1

=#
