#!/usr/bin/env julia

using Test: @test, @testset

function remove_one(ints::Array{T}) where T <: Integer
	if length(ints) < 3 return true end
	comparisons = map(x -> ints[x] < ints[x + 1] ? 0 : 1, 1:length(ints) - 1)
	return sum(comparisons) < 2
end

@testset "remove one" begin
	@test remove_one([0, 2, 9, 4, 6]) == true
	@test remove_one([5, 1, 3, 2]) == false
	@test remove_one([2, 2, 3]) == true
end
