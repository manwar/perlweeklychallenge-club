#!/usr/bin/env julia

using Test: @test, @testset

function smallest_index(ints::Vector{T}) where {T<:Integer}
	indices = filter(x -> ints[x] % 10 == x - 1, 1:length(ints))
	return length(indices) > 0 ? indices[1] - 1 : -1
end

@testset "smallest index" begin
	@test smallest_index([0, 1, 2]) == 0
	@test smallest_index([4, 3, 2, 1]) == 2
	@test smallest_index([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]) == -1
end
