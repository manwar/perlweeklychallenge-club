#! /usr/bin/julia

#time (bash) output: with homeprime.([10,16,20,48,65,96])
#real	0m41.340s
#user	0m41.149s
#sys	0m0.493s

#-- without homeprime(96):
#real	0m4.744s
#user	0m4.745s
#sys	0m0.467s

#-- without .homeprime.([96,65])
#real	0m1.072s
#user	0m1.138s
#sys	0m0.419s

#-- without .homeprime.([96,65,48])
#real	0m1.002s
#user	0m1.095s
#sys	0m0.384s



using Primes

function homeprime(n::Int64)
	return homeprime(BigInt(n))
end

function homeprime(n::BigInt)
	ncopy=n
	while (!isprime(ncopy))
		ncopy=parse(BigInt,join(factor(Vector,ncopy)))
	end
	return ncopy
end

println(homeprime(10))
#773

println(homeprime(16))
#31636373

println(homeprime(20))
#3318308475676071413

println(homeprime(48))
#6161791591356884791277

println(homeprime(65))
#1381321118321175157763339900357651

println(homeprime(96))
#172929671097972226356946608292031596899264419

