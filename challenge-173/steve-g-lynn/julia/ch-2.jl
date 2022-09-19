#!/usr/bin/julia

sylvester=BigInt[2]

for i = 2:10
	push!(sylvester,sylvester[i-1]*(sylvester[i-1]-1)+1)
end

println(sylvester)

