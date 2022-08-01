#!/usr/bin/env julia

for i in 1:200000
	if sort(digits(i*2))!=sort(digits(i*3))
		continue
	elseif sort(digits(i*3))!=sort(digits(i*4))
		continue
	elseif sort(digits(i*4))!=sort(digits(i*5))
		continue
	elseif sort(digits(i*5))!=sort(digits(i*6))
		continue
	end
	println(i)
	break
end

