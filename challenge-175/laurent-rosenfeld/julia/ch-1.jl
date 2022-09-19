using Dates

function sundays(year, month)
    month_end = Dates.lastdayofmonth(Dates.Date(year, month, 1))
    weekday = Dates.dayofweek(month_end)
    println(month_end - Dates.Day(weekday % 7))
end

year = parse( Int, ARGS[1])
for month in 1:12
    sundays(year, month)
end
