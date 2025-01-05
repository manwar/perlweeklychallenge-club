#!/usr/bin/env julia

using Test: @test, @testset

using Combinatorics

function stepByStep(ints::Vector{Int})::Int
    (xₘᵢₙ, result) = (0, 0)
    for i in ints
        result += i
        if result < xₘᵢₙ
            xₘᵢₙ = result
        end
    end

    if xₘᵢₙ == 0
        return 1
    else
        return 1 - xₘᵢₙ
    end
end

@testset "step by step" begin
    @test stepByStep([-3, 2, -3, 4, 2]) == 5
    @test stepByStep([1, 2]) == 1
    @test stepByStep([1, -2, -3]) == 5
end


