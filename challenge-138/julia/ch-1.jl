# The Weekly Challenge Week 138
# Task 1 Work Days
# Usage: include("ch-1.jl")
#        num_of_work_days(year)

using Dates

workday(x) = (
           Dates.dayofweek(x) != Dates.Sunday 
        && Dates.dayofweek(x) != Dates.Saturday
)



function num_of_work_days(year)
    ans = 0
    my_day = Date(year, 1, 1)
    while Dates.dayofweek(my_day) != Dates.Monday
        if workday(my_day)
            ans += 1
        end
        my_day += Dates.Day(1)
    end

    FirstMondayJan = my_day

    SundayDec = Dates.lastdayofweek(Date(year,12,31))
    if (Dates.year( SundayDec + Dates.Day(1) ) == year+1)
        SundayDec -= Dates.Day(7)
    end


    LastMondayDec = SundayDec + Dates.Day(1);
    
    ans += 5*(dayofyear(LastMondayDec) - dayofyear(FirstMondayJan))/7
    # early version of CY's code: ans += 5*51
    ans = convert(Int64, ans)

    my_day = LastMondayDec
    while Dates.year(my_day) == year
        if workday(my_day)
            ans += 1
        end
        my_day += Dates.Day(1)
    end

    return ans

end



function simple_days_count(year)
    i = 0
    my_day = Date(year, 1, 1)
    while Dates.year(my_day) == year
        if workday(my_day)
            i += 1
        end
        my_day += Dates.Day(1)
    end
    return i
end


# testing
for y = 1900:2400
    if simple_days_count(y) != num_of_work_days(y)
        println("big event in ", y)
    end
end


#= benchmarking

julia> function sdc()
           for i = 1975:2400
               simple_days_count(i)
           end
       end
sdc (generic function with 1 method)

julia> function nowd()
           for i = 1975:2400
               num_of_work_days(i)
           end
       end
nowd (generic function with 1 method)

julia> @benchmark sdc()
 Time  (median):     2.463 ms              ┊ GC (median):    0.00%
 Time  (mean ± σ):   2.463 ms ± 65.409 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%

julia> @benchmark nowd()
 Time  (median):     74.457 μs               ┊ GC (median):    0.00%
 Time  (mean ± σ):   74.970 μs ±   3.365 μs  ┊ GC (mean ± σ):  0.00% ± 0.00%



=#
