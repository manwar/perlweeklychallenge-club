#!/usr/bin/env julia
#=
-------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-24
Challenge 227 Task 1 Friday 13th ( Julia )
-------------------------------------
=#
using Printf
using Dates

function checkArgs(args)
  global year
  try
    year = parse(Int64, args[1])
  catch
    println("Please enter a year between 1753 and 9999")
    exit(0)
  finally
    if year < 1753 || year > 9999
      println("Please enter a year between 1753 and 9999")
      exit(0)
    else
      main(year)
    end
  end
end

function main(year)
  for month in 1:12
    d = Dates.Date(year,month,13)
    wd = Dates.dayofweek(d)
    if wd == 5      ### 5 is Friday
        @printf("%d %d 13 is a Friday\n",year, month)
    end
  end
end

checkArgs(ARGS)

#=
-------------------------------------
SAMPLE OUTPUT
julia .\Friday13.jl 2023

2023 1 13 is a Friday
2023 10 13 is a Friday

julia .\Friday13.jl 1753

1753 4 13 is a Friday
1753 7 13 is a Friday
-------------------------------------
=#


