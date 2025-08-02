#!/usr/bin/env julia

using Test: @test, @testset

function special_numbers(n::Vector{T}) where {T<:Integer}
	return sum(map(x -> n[x]^2, filter(x -> length(n) % x == 0, 1:length(n))))
end

@testset "special numbers" begin
	@test special_numbers([1, 2, 3, 4]) == 21
	@test special_numbers([2, 7, 1, 19, 18, 3]) == 63
end
