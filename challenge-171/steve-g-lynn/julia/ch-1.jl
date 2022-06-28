#!/usr/bin/julia

function sum_factors(n::Int64)
	mysum=1
	for factor=2:(Int64(floor((n/2))))
		if (n % factor == 0)
			mysum += factor
		end
	end
	return mysum
end

retvec=Int64[]
              
for n in (3:2:10000)
# loop over odd numbers only
	if (sum_factors(n) > n)
		global retvec=[retvec;n]
	end
	if (length(retvec) > 19)
		break
	end
end

println(retvec)

              

