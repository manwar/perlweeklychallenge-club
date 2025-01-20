#!/usr/bin/env julia

using Test: @test, @testset

function arrangeBinaries(digits::Vector{Int}, n::Int)::Bool
    numberOfOnes = count(x -> x == 1, digits) + n
    return numberOfOnes ≤ length(digits) - numberOfOnes + 1
end

@testset "arrange binary" begin
    @test arrangeBinaries([1, 0, 0, 0, 1], 1)
    @test !(arrangeBinaries([1, 0, 0, 0, 1], 2))
end
