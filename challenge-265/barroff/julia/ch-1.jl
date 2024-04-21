#!/usr/bin/env julia

using Test: @test, @testset

function thirtythree_appearance(ints::Vector{T})::T where {T<:Integer}
    third = length(ints) / 3
    thirds = filter(x -> count(y -> y == x, ints) ≥ third, unique(ints))
    if length(thirds) > 0
        return minimum(thirds)
    end
    return NaN

end

@testset "33% appearance" begin
    @test thirtythree_appearance([1, 2, 3, 3, 3, 3, 4, 2]) == 3
    @test thirtythree_appearance([1, 1]) == 1
    @test thirtythree_appearance([1, 2, 3]) == 1
end
