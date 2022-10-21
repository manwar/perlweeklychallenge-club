#!/usr/bin/env julia

using Dates

function parse_date(str::String) ::Date
    day_mth=split(str,"-")
    return Date(2022,parse(Int64,day_mth[2]),parse(Int64,day_mth[1]))
end

function days_together(foo_sd::String, foo_ed::String, bar_sd::String, bar_ed::String) ::Day

    # Get later start date
    if parse_date(foo_sd) > parse_date(bar_sd)
        later_sd = parse_date(foo_sd)
    else
        later_sd = parse_date(bar_sd)
    end
    
    # get earlier end date
    if parse_date(foo_ed) > parse_date(bar_ed)
        earlier_ed = parse_date(bar_ed)
    else
        earlier_ed = parse_date(foo_ed)
    end
    
    #-- get date difference
    if later_sd > earlier_ed
        return Day(0)
    else
        return earlier_ed - later_sd + Day(1)
    end
end

println( days_together("12-01","20-01","15-01","18-01") )
#4 days
println( days_together("02-03","12-03","13-03","14-03") )
#0 days
println( days_together("02-03","12-03","11-03","15-03") )
#2 days
println( days_together("30-03","05-04","20-03","02-04") )
#4 days

