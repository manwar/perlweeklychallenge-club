#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-11-07

Challenge 190 Capital Detection ( Julia )



You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate

if it satisfies at least one of the following rules:



1) Only first letter is capital and all others are small.

2) Every letter is small.

3) Every letter is capital.



SAMPLE OUTPUT

Input: $s = "Perl"

Output: 1



Input: $s = "TPF"

Output: 3



Input: $s = "PyThon"

Output: 0



Input: $s = "raku"

Output: 2

=#



using Printf

words = ["Perl", "TPF", "PyThon", "raku"]



for s in words

  @printf("Input: \$s = \"%s\"\n",s)

  if occursin(r"^[A-Z][a-z]*$", s )

    @printf("Output: 1\n")

  elseif occursin(r"^[a-z]*$", s)

    @printf("Output: 2\n")

  elseif occursin(r"^[A-Z]*$", s)

    @printf("Output: 3\n")

  else

    @printf("Output: 0\n")

  end

  println(" ")

end
