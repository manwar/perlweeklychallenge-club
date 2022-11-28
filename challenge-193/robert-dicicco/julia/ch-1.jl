#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-11-28

Challenge 193 Binary String ( Julia )

 

Write a script to find all possible binary numbers of size $n.

Example 1

 

Input: $n = 2

Output: 00, 11, 01, 10

 

Example 2

 

Input: $n = 3

Output: 000, 001, 010, 100, 111, 110, 101, 011

------------------------------------------------------

SAMPLE OUTPUT

julia .\BinaryString.jl

Input: $n = 2

Output: 00 01 10 11

 

Input: $n = 3

Output: 000 001 010 011 100 101 110 111

 

Input: $n = 4

Output: 0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111

=#

 

using Printf

 

arr = [2,3,4]

maxv = [3,7,15]

 

x = 1

for p in arr

  @printf("Input: \$n = %d\n", p)

  @printf("Output: ")

  global x

  for n in (0:maxv[x])

    @printf("%s ", string(n, base=2, pad=p))

  end

  println("\n")

  x += 1

end
