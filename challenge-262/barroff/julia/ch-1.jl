#!/usr/bin/env julia

using Test: @test, @testset

function max_positive_negative(ints::Vector{T})::Int where {T<:Integer}
	maximum([count(x -> x > 0, ints), count(x -> x < 0, ints)])
end

@testset "count even digits number" begin
    @test max_positive_negative([-3, 1, 2, -1, 3, -2, 4]) == 4
    @test max_positive_negative([-1, -2, -3, 1]) == 3
    @test max_positive_negative([1, 2]) == 2
end
