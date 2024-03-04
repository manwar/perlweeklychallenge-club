#!/usr/bin/env julia

using Test: @test, @testset

function sum_of_values(ints::Vector{T}, k::T) where {T<:Integer}
	sum(
		ints[
			filter(
				x -> count(y -> y == '1', string(x - 1, base=2)) == k,
				1:length(ints)
			)
		]
	)
end

@testset "count even digits number" begin
	@test sum_of_values([2, 5, 9, 11, 3], 1) == 17
	@test sum_of_values([2, 5, 9, 11, 3], 2) == 11
	@test sum_of_values([2, 5, 9, 11, 3], 0) == 2
end
