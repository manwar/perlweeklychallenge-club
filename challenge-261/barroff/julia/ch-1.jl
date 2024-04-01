#!/usr/bin/env julia

using Test: @test, @testset

function element_digit_sim(ints::Vector{T})::Int where {T<:Integer}
    sum(ints) - sum([sum([parse(Int, y) for y in split(string(x), "")]) for x in ints])
end

@testset "count even digits number" begin
    @test element_digit_sim([1, 2, 3, 45]) == 36
    @test element_digit_sim([1, 12, 3]) == 9
    @test element_digit_sim([1, 2, 3, 4]) == 0
    @test element_digit_sim([236, 416, 336, 350]) == 1296
end
