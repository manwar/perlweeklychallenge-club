#!/usr/bin/env julia

using Test: @test, @testset

function zero_array(ints::Array{Int})
    return length(filter(x -> x > 0, unique(ints)))
end

@testset "zero array" begin
    @test zero_array([1, 5, 0, 3, 5]) == 3
    @test zero_array([0]) == 0
    @test zero_array([2, 1, 4, 0, 3]) == 4
end

