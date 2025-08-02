#!/usr/bin/env julia

using Test: @test, @testset

function middle_index(ints::Vector{T})::Int where {T<:Integer}
    if sum(ints[2:end]) == 0
           return 0
    end
    mi = findfirst(x -> sum(ints[1:x-1]) == sum(ints[x+1:end]), 2:length(ints) - 1)
    if isnothing(mi)
        return sum(ints[1:end-1]) == 0 ? length(ints) - 1 : -1
    else
        return mi
    end
end

@testset "middle index" begin
    @test middle_index([2, 3, -1, 8, 4]) == 3
    @test middle_index([1, -1, 4]) == 2
    @test middle_index([2, 5]) == -1
    @test middle_index([8, -1, 1]) == 0
end
