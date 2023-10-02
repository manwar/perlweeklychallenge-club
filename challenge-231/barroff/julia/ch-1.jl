#!/usr/bin/env julia

using Test: @test, @testset

function min_max(ints::Array{T}) where T <: Integer
	if length(ints) < 3 return -1 end
	sorted_ints = sort(ints)
	return sorted_ints[2:end-1]
end

@testset "senior citizen" begin
	@test min_max([3, 2, 1, 4]) == sort([3, 2])
	@test min_max([3, 1])       == -1
	@test min_max([2, 1, 3])    == [2]
end
