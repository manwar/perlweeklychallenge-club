#!/usr/bin/env julia

using Combinatorics;

function rank2permutation(a::Vector, n::Int)
	return nthperm(sort(a),n+1)
end


function permutation2rank(a::Vector)
	perms=permutations(sort(a))
	ctr=0
	for i in perms
		if (a==i) 
			break
		end
		ctr = ctr+1
	end
	return ctr
end

println(rank2permutation([0,1,2],1)) # [0,2,1]
println(permutation2rank([1,0,2])) #2				     

