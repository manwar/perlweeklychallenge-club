#!/usr/bin/env julia

#real	0m0.719s
#user	0m0.789s
#sys	0m0.414s

using Primes;

global retval=Int64[]

function find_cyclops(n1::Int64, n2::Int64)
	for i in n1:n2
		if !isprime(i)
			continue #-- next
		end
		mydigits=digits(i)
		sorted_digits=sort(mydigits)

		if sorted_digits[2]==0
		#-- more than one zero in the candidate
			continue 
		end
		
		mylen=length(mydigits)
		if mydigits[Int(mylen/2+0.5)] != 0
			continue
		end
		
		reverse_digits=reverse(mydigits)
		if mydigits[1:(Int(mylen/2-0.5))] !=
		 reverse_digits[1:(Int(mylen/2-0.5))]
			continue
		end

		push!(retval, i)
		if length(retval) > 19
			break
		end
	end
end 

find_cyclops(101,999)
find_cyclops(10001,99999)
find_cyclops(1000001,9999999)

println(retval)

#[101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049, 1120211,
# 1150511, 1160611, 1180811, 1190911, 1250521, 1280821, 1360631, 1390931,
# 1490941, 1520251]

