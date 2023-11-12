#!/usr/bin/env julia

using Test: @test, @testset

function missing_members(arr1::Array{T}, arr2::Array{T}) where {T<:Integer}
    set1 = Set{T}(arr1)
    set2 = Set{T}(arr2)
    return (setdiff(set1, set2), setdiff(set2, set1))
end

@testset "missing members" begin
    @test missing_members([1, 2, 3], [2, 4, 6]) == (Set([1, 3]), Set([4, 6]))
    @test missing_members([1, 2, 3, 3], [1, 1, 2, 2]) == (Set([3]), Set{Int64}())
end
