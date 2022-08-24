#!/usr/bin/env julia

using Statistics

function sparkline(data::Vector{Float64})
	med = median(data)
	stddev = std(data)
	for datum in data
		if ((datum >= med - stddev) && (datum <= med+stddev))
			print("▂")
		elseif (datum < med - stddev)
			print("▁")
		elseif (datum > med + stddev)
			print("▃")
		else
			break
		end
	end
	println("")
end

mydata=[1.0,2.0,3.0,4.0,5.0,4.0,3.0,2.0,1.0]

sparkline(mydata)

#▁▂▂▂▃▂▂▂▁




