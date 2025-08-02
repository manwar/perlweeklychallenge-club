#!/usr/bin/env julia

using Test: @test, @testset

function multiply_by_two(start::T, ints::Vector{T})::Int where {T<:Integer}
    start in ints ? multiply_by_two(2 * start, ints) : start
end

@testset "count even digits number" begin
    @test multiply_by_two(3, [5, 3, 6, 1, 12]) == 24
    @test multiply_by_two(1, [1, 2, 4, 3]) == 8
    @test multiply_by_two(2, [5, 6, 7]) == 2
end
