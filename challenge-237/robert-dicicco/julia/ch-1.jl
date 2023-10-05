#!/usr/bin/env julia
#=
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-04
Challenge 237 Task 01 Seize the Day ( Julia )
-----------------------------------------
=#
using Printf
using Dates

year = parse(Int64,ARGS[1])
month = parse(Int64,ARGS[2])
weekday_of_month = parse(Int64,ARGS[3])
day_of_week = parse(Int64,ARGS[4])
cnt = 1
fnd = 0

@printf("Input: Year = %d, Month = %d, Weekday of month = %d, day of week = %d\n",year,month,weekday_of_month,day_of_week)
t = Date(year, month, 1)
days_in_month =  Dates.daysinmonth(t)
d = 1
while  d <= days_in_month
    global d,day_of_week,weekday_of_month,day_of_week,cnt,fnd
    t2 = Date(year, month, d)
    dow = Dates.dayofweek(t2) - 1
    if dow == day_of_week
        if cnt == weekday_of_month
             @printf("Output: %d\n", d - 1)
            fnd += 1
            break
        end
        cnt += 1
    end
    d += 1
end
if (fnd == 0)
    println("Output: 0")
end

#=
------------------------------------------
SAMPLE OUTPUT
julia .\SeizeDay.jl 2024 4 3 2

Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
Output: 16

julia .\SeizeDay.jl 2025 10 2 4

Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
Output: 9

julia .\SeizeDay.jl 2026 8 5 3

Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
Output: 0
-----------------------------------------
=#


