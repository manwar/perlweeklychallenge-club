#! /usr/bin/julia

using Primes

function homeprime(n::Int64)
	ncopy=n
	while (!isprime(ncopy))
		ncopy=parse(Int64,join(factor(Vector,ncopy)))
	end
	return ncopy
end

println(homeprime(16))
#31636373

