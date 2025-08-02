#!/usr/bin/env julia

using Test: @test, @testset

function unique_number(ints::Vector{T})::Int where {T<:Integer}
    numbercounts = Dict{T,Int}()
    map(x -> numbercounts[x] = get(numbercounts, x, 0) + 1, ints)
    indices = collect(keys(numbercounts))
    indices[findfirst(x -> numbercounts[x] == 1, indices)]
end

@testset "unique number" begin
    @test unique_number([3, 3, 1]) == 1
    @test unique_number([3, 2, 4, 2, 4]) == 3
    @test unique_number([1]) == 1
    @test unique_number([4, 3, 1, 1, 1, 4]) == 3
end
