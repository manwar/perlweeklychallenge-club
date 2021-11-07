# The Weekly Challenge Week 137
# Task 1 Long Year
# Usage: include("ch-1.jl")

using Dates

t(y) = Date(y, 1, 4)
e(y) = Date(y, 12, 31)

global c = 0;

for y = 1900:2100
    if Dates.week(e(y)) - Dates.week(t(y)) == 52
        println(y)
        global c = c+1
    end
end

println("Number of Long Years: " , c)
