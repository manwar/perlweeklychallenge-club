#!/usr/bin/env julia

#real	0m1.126s
#user	0m1.196s
#sys	0m0.417s

#-- for integer abc.. return a^1+b^2+c^3...
function get_poly(n::Int) ::Int
	narry = digits(n); #-- array of digits in reverse order
	indx=(length(narry)):-1:1
	return sum(narry .^ indx)
end

for i in 0:3000000
	if (get_poly(i)==i)
		println(i)
	end
end
 
