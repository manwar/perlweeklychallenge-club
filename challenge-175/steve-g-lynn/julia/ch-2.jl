#!/usr/bin/julia

using Primes

function iterated_totient(n::Int) ::Int
	my_totient = totient(n)
	if my_totient==1
		return 1
	else
		return my_totient+iterated_totient(my_totient)
	end
end

ctr=0
for i in 2:10000
	if i==iterated_totient(i)
		println(i)
		global ctr=ctr+1
	end
	if ctr > 19
		break
	end
end 
