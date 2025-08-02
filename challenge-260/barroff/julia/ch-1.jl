#!/usr/bin/env julia

using Test: @test, @testset

function unique_values(ints::Vector{T})::Int where {T<:Integer}
    unique_numbers = unique(ints)
    Int(
        length(unique_numbers) ==
        length(unique(map(x -> count(y -> y == x, ints), unique_numbers))),
    )
end

@testset "count even digits number" begin
    @test unique_values([1, 2, 2, 1, 1, 3]) == 1
    @test unique_values([1, 2, 3]) == 0
    @test unique_values([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]) == 1
end
