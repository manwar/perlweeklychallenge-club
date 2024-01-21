#!/usr/bin/env julia

using Test: @test, @testset

function unique_sum_zero(n::T) where {T<:Integer}
	ints = []
	map(x -> append!(ints, [x, -x]), 1:Int(floor(n / 2)))
	if n % 2 == 1
		append!(ints, 0)
	end
	sort!(ints)
	return ints
end

@testset "unique sum zero" begin
	@test unique_sum_zero(5) == [-2, -1, 0, 1, 2]
	@test unique_sum_zero(3) == [-1, 0, 1]
	@test unique_sum_zero(1) == [0]
	@test unique_sum_zero(0) == []
end
