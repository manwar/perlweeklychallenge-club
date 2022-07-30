# The Weekly Challenge - 137
# Task 1 Long Year

using Dates

function last_sun_month(yr, month)
    temp = Date(yr, month, 1)
    return temp-Dates.Day(Dates.dayofweek(temp))
end

function last_sun_year(yr)
    ans = []
    for i = 2:12
        push!(ans,last_sun_month(yr,i))
    end
    ny = Date(yr+1, 1, 1)
    push!(ans, ny-Dates.Day(Dates.dayofweek(ny)))
    return ans
end

last_sun_year(2022)
