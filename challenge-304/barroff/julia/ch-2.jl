#!/usr/bin/env julia

using Test: @test, @testset

function maximumAverage(ints::Vector{Int}, n::Int)::Float64
    return maximum(
        map(
            x -> sum(ints[x:x+n-1]),
            1:length(ints)-n+1)
    ) / n
end

@testset "maximum average" begin
    @test maximumAverage([1, 12, -5, -6, 50, 3], 4) == 12.75
    @test maximumAverage([5], 1) == 5
end
