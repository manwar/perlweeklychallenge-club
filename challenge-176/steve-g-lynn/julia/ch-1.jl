#!/usr/bin/env julia

for i in 1:200000
	mydigits=sort(digits(i))
	if sort(digits(i*2))!=mydigits
		continue
	elseif sort(digits(i*3))!=mydigits
		continue
	elseif sort(digits(i*4))!=mydigits
		continue
	elseif sort(digits(i*5))!=mydigits
		continue
	elseif sort(digits(i*6))!=mydigits
		continue
	end
	println(i)
	break
end

