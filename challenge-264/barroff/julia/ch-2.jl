#!/usr/bin/env julia

using Test: @test, @testset

function target_array(source::Vector{T}, indices::Vector{T}) where {T<:Integer}
    if length(source) == 1
        return source
    end
    target = [source[1]]
    map(x -> splice!(target, indices[x]+1:indices[x], source[x]), 2:length(source))
    return target
end

@testset "target array" begin
    @test target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]) == [0, 4, 1, 3, 2]
    @test target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]) == [0, 1, 2, 3, 4]
    @test target_array([1], [0]) == [1]
end
