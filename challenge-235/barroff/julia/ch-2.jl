#!/usr/bin/env julia

using Test: @test, @testset

function duplicate_zeros(ints::Array{T}) where T <: Integer
	result = T[]
	map(x -> x == 0 ? push!(result, 0, 0) : push!(result, x), ints)
	return result[1:length(ints)]
end

@testset "duplicate zeros" begin
	@test duplicate_zeros([1, 0, 2, 3, 0, 4, 5, 0]) == [1, 0, 0, 2, 3, 0, 0, 4]
	@test duplicate_zeros([1, 2, 3]) == [1, 2, 3]
	@test duplicate_zeros([0, 3, 0, 4, 5]) == [0, 0, 3, 0, 0]
end
