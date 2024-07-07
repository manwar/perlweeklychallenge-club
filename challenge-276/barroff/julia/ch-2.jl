#!/usr/bin/env julia

using Test: @test, @testset

function maximum_frequency(ints::Vector{T})::Int where {T<:Integer}
    numbercounts = Dict{T,Int}()
    map(x -> numbercounts[x] = get(numbercounts, x, 0) + 1, ints)
    most_occurrences = maximum(values(numbercounts))
    return count(
        x -> numbercounts[x] == most_occurrences,
        keys(numbercounts)
    ) * most_occurrences
end

@testset "maxumum frequency" begin
    @test maximum_frequency([1, 2, 2, 4, 1, 5]) == 4
    @test maximum_frequency(collect(1:5)) == 5
end
