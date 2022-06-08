#!/usr/bin/julia
#-- slower than perl or raku for this task because of slow startup

using Primes

function perrin(n::Int64)
	return ( ([0 1 0; 0 0 1; 1 1 0]^n)*[3;0;2] )[1];
end

savedprimes=Array{Int64}(undef,13)
savedprimes[1]=2; savedprimes[2]=3;savedprimes[3]=5;savedprimes[4]=7
ctr=3;

for n in (6:1000)
	perrinval=perrin(n)
	if (isprime(perrinval) && (ctr <=13))
		savedprimes[ctr]=perrinval
		global ctr=ctr+1
	end
end

print("(")
for n in (1:13)
	print(savedprimes[n])
	print(" ")
end
print(")\n")


