#!/usr/bin/env julia

using Test: @test, @testset

function third_maximum(ints::Vector{T})::Int where {T<:Integer}
    unique_ints = unique(ints)
    return length(unique_ints) > 2 ? sort(unique_ints)[end-2] : maximum(unique_ints)
end

@testset "third maximum" begin
    @test third_maximum([5, 6, 4, 1]) == 4
    @test third_maximum([4, 5]) == 5
    @test third_maximum([1, 2, 2, 3]) == 1
end
