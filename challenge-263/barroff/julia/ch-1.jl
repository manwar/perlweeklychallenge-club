#!/usr/bin/env julia

using Test: @test, @testset

function target_index(k::T, ints::Vector{T}) where {T<:Integer}
	findall(x -> x == k, sort(ints)) .- 1
end

@testset "target index" begin
	@test target_index(2, [1, 5, 3, 2, 4, 2]) == [1, 2]
	@test target_index(6, [1, 2, 4, 3, 5]) == []
	@test target_index(4, [5, 3, 2, 4, 2, 1]) == [4]
end
