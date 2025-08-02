#!/usr/bin/env julia

using Test: @test, @testset

function is_strong_pair(x::S, y::T)::Bool where {S<:Real,T<:Real}
    if x == y
        return false
    end
    return abs(x - y) < min(x, y)
end


function strong_pair(ints::Vector{T})::Int where {T<:Real}
    unique_ints = unique(ints)
    length(
        filter(
            x -> x,
            [
                is_strong_pair(unique_ints[x], unique_ints[y]) for x in 1:length(unique_ints)-1 for y in x+1:length(unique_ints)
            ]
        )
    )

end

@testset "strong pair" begin
    @test strong_pair([1, 2, 3, 4, 5]) == 4
    @test strong_pair([5, 7, 1, 7]) == 1
end
