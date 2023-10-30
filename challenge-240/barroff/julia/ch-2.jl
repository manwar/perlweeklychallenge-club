#!/usr/bin/env julia

using Test: @test, @testset

function build_array(ints::Array{T}) where T <: Integer
	return map(x -> ints[x] + 1 > length(ints) ? NaN : ints[ints[x] + 1], 1:length(ints))
end

@testset "build array" begin
	@test build_array([0, 2, 1, 5, 3, 4]) == [0, 1, 2, 4, 5, 3]
	@test build_array([5, 0, 1, 2, 3, 4]) == [4, 5, 0, 1, 2, 3]
end
