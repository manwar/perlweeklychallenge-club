#!/usr/bin/julia

#real	0m1.056s
#user	0m1.092s
#sys	0m0.432s

using Statistics;

function fivenum(x::Vector{Float64})
	retval=zeros(5)
	index=1
	for i in 0:0.25:1
		retval[index]=quantile(x,i)
		index += 1    #-- no x++ in julia
	end
	return retval
end

test=rand(913613)
println(fivenum(test))

#[7.201802328937745e-7, 0.24952215316332127, 0.4996753331905286,
# 0.7502263126585448, 0.9999999848985451]

