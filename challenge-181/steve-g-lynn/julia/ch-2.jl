#!/usr/bin/env julia

using Dates

temperatures=readlines("../temperature.txt")

temperatures=split.(temperatures,", ")

temperature_hash=Dict{Date,Int64}()

for i in 1:length(temperatures)
	temperature_hash[parse(Date,temperatures[i][1])]=parse(Int64,temperatures[i][2])
end

for i in keys(temperature_hash)
	if !haskey(temperature_hash,i-Dates.Day(1))
		continue
	end
	if temperature_hash[i-Dates.Day(1)] < temperature_hash[i]
		println(i)
	end
end

#-- (returns dates in unsorted order)
#2022-08-08
#2022-08-02
#2022-08-06
#2022-08-05
#2022-08-10

