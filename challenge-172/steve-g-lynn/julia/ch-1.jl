#!/usr/bin/julia

#real	0m3.733s
#user	0m3.713s
#sys	0m0.476s


using Primes;

#-- functions
function prime_partition(m::Int, n::Int)::Matrix{Int}
	retval=Array{Int}(undef,0,n)                
	if (n==2)
		for i in primes(m ÷ 2)
			if (isprime(m-i))
				retval=[retval;i m-i]
			end
		end
		retval=sort_partition(retval)
		retval=delete_equal_rows(retval)
		return retval
	end
	if  (n > 2)
		for i in primes(m ÷ n)
			p=prime_partition(m-i, n-1)
			if (size(p)[1] > 0)
				sizep=size(p)
				retval=[retval; (i .* ones(Int,sizep[1])) p]
			end
		end
		retval=sort_partition(retval)
		retval=delete_equal_rows(retval)
		return retval
	end
end

function sort_partition(p::Matrix{Int})::Matrix{Int}
	return sortslices(sort(p,dims=2),dims=1)
end

function delete_equal_rows(p::Matrix{Int})::Matrix{Int}
#-- matrix must be sorted first by sort_partition
	list_equal=Vector{Int}();	
	for i in 1:size(p,1)-1
		if p[i+1,:]==p[i,:]
			append!(list_equal,i+1)
		end
	end
	return p[setdiff(1:size(p,1),list_equal),:]
end

#-- main
println(prime_partition(18,2))
println(prime_partition(19,3))
println(prime_partition(200,3))
println(prime_partition(200,4))
println(prime_partition(1000,3))
println(prime_partition(10000,3))
println(prime_partition(80000,3))
println(prime_partition(200,5))

