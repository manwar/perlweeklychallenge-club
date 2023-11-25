#!/usr/bin/env julia

using Test: @test, @testset

function reverse_pairs(nums::Vector{T}) where {T<:Integer}
    sum(map(x -> length(filter(y -> x[2] > 2 * y, nums[x[1]:end])), enumerate(nums)))
end

@testset "reverse pairs" begin
    @test reverse_pairs([1, 3, 2, 3, 1]) == 2
    @test reverse_pairs([2, 4, 3, 5, 1]) == 3
end
