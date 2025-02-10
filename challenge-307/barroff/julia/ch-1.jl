#!/usr/bin/env julia

using Test: @test, @testset

function checkOrder(ints::Vector{Int})::Vector{Int}
    sortedInts = sort(ints)
    return filter(x -> ints[x] != sortedInts[x], 1:length(ints)) .- 1
end

@testset "check order" begin
    @test checkOrder([5, 2, 4, 3, 1]) == [0, 2, 3, 4]
    @test checkOrder([1, 2, 1, 1, 3]) == [1, 3]
    @test checkOrder([3, 1, 3, 2, 3]) == [0, 1, 3]
end
