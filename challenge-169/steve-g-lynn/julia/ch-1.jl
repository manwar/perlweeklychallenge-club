#!/usr/bin/julia

using Primes
using IterTools

brilliant=[]


#-- produce a vector of all products of items in an input vector
#-- (such as a vector of primes)

function myprods(a)
	retval=[]
	for i in product(a,a) #-- cartesian product i=(a[j],a[k])
		retval=[retval; prod(i)] #-- product of the pair in i
       	end
       	return retval
end

brilliant=[brilliant; myprods(primes(10)); myprods(primes(11,99))]

#-- primes(10): 1-digit primes; primes(11,99): 2-digit primes

brilliant=sort(unique(brilliant))[1:20]

println(brilliant)

