#!/usr/bin/env julia

using Test: @test, @testset

function smaller_than_current(ints::Vector{T}) where {T<:Integer}
	map(x -> length(filter(y -> y < x, ints)), ints)
end

@testset "smaller than current" begin
	@test smaller_than_current([5, 2, 1, 6]) == [2, 1, 0, 3]
	@test smaller_than_current([1, 2, 0, 3]) == [1, 2, 0, 3]
	@test smaller_than_current([0, 1]) == [0, 1]
	@test smaller_than_current([9, 4, 9, 2]) == [2, 1, 2, 0]
end
