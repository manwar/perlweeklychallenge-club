#!/usr/bin/env julia

using Test: @test, @testset

function i_to_s(x::Int64)
	return "$(x)"
end

function s_to_i(x)
	return parse(Int64, x)
end

function separate_digits(ints::Array{Int64})
	s_to_i.(split(join(i_to_s.(ints)), ""))
end

@testset "separate digits" begin
    @test separate_digits([ 1, 34, 5, 6 ]) == [1, 3, 4, 5, 6]
    @test separate_digits([ 1, 24, 51, 60 ]) == [1, 2, 4, 5, 1, 6, 0]
end
