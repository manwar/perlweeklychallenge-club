#!/usr/bin/env/julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-12-05

Challenge 194 Digital Clock ( Julia )

-------------------------------------------

SAMPLE OUTPUT

julia .\DigitalClock.jl

Input: time = ?5:00

Output: 1

 

Input: time = ?3:00

Output: 2

 

Input: time = 1?:00

Output: 9

 

Input: time = 2?:00

Output: 3

 

Input: time = 12:?5

Output: 5

 

Input: time = 12:5?

Output: 9

=#

 

using Printf

 

templates = ["?5:00", "?3:00", "1?:00", "2?:00", "12:?5","12:5?"]

 

function GetDigit(tp, n)

  @printf("Input: time = %s\n",tp)

  @printf("Output: ")

  if (( n == 1 ) && (tp[2] < '4'))

     @printf("2\n\n")

  elseif (( n == 1 ) && (tp[2] >= '4' ))

     @printf("1\n\n")

  elseif (( n == 2 ) && (tp[1] <= '1'))

     @printf("9\n\n")

  elseif (( n == 2 ) && (tp[1] == '2'))

     @printf("3\n\n")

  elseif ( n == 4)

     @printf("5\n\n")

  elseif ( n == 5)

     @printf("9\n\n")

  else

     println("Error!")

  end

end

 

for tp in templates

  ndx = findfirst("?", tp)[1]

  GetDigit(tp,ndx);

end
