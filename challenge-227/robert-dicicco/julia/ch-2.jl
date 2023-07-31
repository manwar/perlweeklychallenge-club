#!/usr/bin/env julia
#=
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-28
Challenge 227 Task 2 Roman Maths ( Julia )
------------------------------------------
=#
using Printf
using RomanNumerals

numerals = Dict(
    "I" => 1,
    "V" => 5,
    "X" => 10,
    "L" => 50,
    "C" => 100,
    "D" => 500,
    "M" => 1000
  )

special_numerals = Dict(
    "IV" => 4,
    "IX" => 9,
    "XL" => 40,
    "XC" => 90,
    "CD" => 400,
    "CM" => 900
  )

special_sum = 0
normal_sum = 0

function roman_to_int(s)
  global special_sum, normal_sum, numerals
  special_sum = 0
  normal_sum = 0
  while(length(s) > 0)
    if (length(s) > 1) && occursin(r"(IV|IX|XL|XC|CD|CM)",s[1:2])
        special_sum += special_numerals[string(s[1:2])]
        s=chop(s,head=2,tail=0)
    else
        normal_sum += numerals[string(s[1])]
        s=chop(s,head=1,tail=0)
    end
  end
  return special_sum + normal_sum
end

n = length(ARGS)
if ( n != 1 )
    print("Please enter a math problem using Roman numerals")
    exit(1)
end

problem = uppercase(ARGS[1])
parts = split(problem)
left = parts[1]

op = parts[2]
right = parts[3]

lft = roman_to_int(left)
rt = roman_to_int(right)

if cmp(op,"-") == 0  && (lft - rt == 0)
        @printf("%s est nulla\n",problem)
        exit(1)
    elseif cmp(op,"/") == 0 && (lft % rt) > 0
        @printf("%s non potest",problem)
        exit(1)
    elseif cmp(op,"+") == 0 && (lft + rt) > 3999
        @printf("%s non potest",problem)
        exit(1)
    elseif cmp(op,"-") == 0 && (lft - rt) < 0
        @printf("%s non potest",problem)
        exit(1)
    elseif cmp(op,"/") == 0 && (lft % rt) != 0
        @printf("%s non potest",problem)
        exit(1)
end

if cmp(op,"+") == 0
        val = RomanNumeral(lft + rt)
    elseif cmp(op,"-") == 0
        val = RomanNumeral(lft - rt)
    elseif cmp(op,"/") == 0
         val = RomanNumeral(trunc(Int,lft/rt))
    elseif cmp(op,"*") == 0
        val = RomanNumeral(lft * rt)
    elseif cmp(op,"**") == 0
        val = RomanNumeral(trunc(Int,lft ^ rt))
end


@printf("%s => %s\n",problem,val)

#=
------------------------------------------
SAMPLE OUTPUT
julia .\RomanMath.jl "IV + V"
IV + V => IX

julia .\RomanMath.jl "M - I"
M - I => CMXCIX

julia .\RomanMath.jl "X / II"
X / II => V

julia .\RomanMath.jl "XI * VI"
XI * VI => LXVI

julia .\RomanMath.jl "VII ** III"
VII ** III => CCCXLIII

julia .\RomanMath.jl "V - V"
V - V est nulla

julia .\RomanMath.jl "V / II"
V / II non potest

julia .\RomanMath.jl "MMM + M"
MMM + M non potest

julia .\RomanMath.jl "V - X"
V - X non potest
------------------------------------------
=#


