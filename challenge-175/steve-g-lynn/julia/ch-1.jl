#!/usr/bin/env julia

using Dates;

function last_sunday(yr::Int)
	for mth in 1:12
		lastday = Dates.lastdayofmonth(Dates.Date(yr,mth,20))
		dr = Dates.Date(yr,mth,20):Day(1):lastday
		lastsun = filter(dr) do x
			Dates.dayofweek(x) == Dates.Sun
		end
		println(last(lastsun))
	end
end

last_sunday(2022)

