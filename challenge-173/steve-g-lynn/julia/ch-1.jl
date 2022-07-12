#!/usr/bin/julia

function is_esthetic(n::Int64)
	n_str=string(n);
	
	for i in 1:length(n_str)-1
		if !((Int(n_str[i+1]) == Int(n_str[i])+1) ||
			(Int(n_str[i+1]) == Int(n_str[i])-1))
			return 0
		end
	end
	return 1
end

println(is_esthetic(5456))
println(is_esthetic(120))

