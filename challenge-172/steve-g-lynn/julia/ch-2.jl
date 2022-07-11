#!/usr/bin/julia

#real	0m1.088s
#user	0m1.117s
#sys	0m0.445s

using Statistics

function fivenum(x::Vector{Float64})
	retval=zeros(5)
	ctr=1
	for i in 0:0.25:1
		retval[ctr]=quantile(x,i)
		ctr += 1
	end
        return retval
end

test=rand(925089)
println(fivenum(test))

#[7.335486141846204e-7, 0.24913072314183482, 0.49950102601650026,
# 0.749602495312535, 0.9999999579699111]

