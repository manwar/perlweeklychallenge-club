#!/usr/bin/env julia

function my_trim(i::Int64, n::Vector{Float64}) ::Vector{Float64}
	return n[n .>= i]
end

println(my_trim(3,[1.0,4.0,2.0,3.0,5.0])) #[4.0, 3.0, 5.0]
println(my_trim(4,[9.0,0.0,6.0,2.0,3.0,8.0,5.0])) #[9.0, 6.0, 8.0, 5.0]

