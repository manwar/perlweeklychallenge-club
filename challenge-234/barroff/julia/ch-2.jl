#!/usr/bin/env julia

using Test: @test, @testset

function is_unequal(a, b, c)
	if a != b && a != c && b != c
		# println("$(a), $(b), $(c)")
		return 1
	end
	return 0
end

function unequal_triplets(ints)
	result = 0
	for i in 1:length(ints) - 2
		for j in i:length(ints) - 1
			for k in j:length(ints)
				result += is_unequal(ints[i], ints[j], ints[k])
			end
		end
	end
	return result
end

@testset "unequal triplets" begin
	@test unequal_triplets([4, 4, 2, 4, 3])           == 3
	@test unequal_triplets([1, 1, 1, 1, 1])           == 0
	@test unequal_triplets([4, 7, 1, 10, 7, 4, 1, 1]) == 28
end
