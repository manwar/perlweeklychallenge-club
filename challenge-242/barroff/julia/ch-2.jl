#!/usr/bin/env julia

using Test: @test, @testset

function flip_matrix(matrix::Array{T,2}) where {T<:Integer}
    map(y -> y == 0 ? 1 : 0, reverse(matrix, dims = (2)))
end

@testset "flip matrix" begin
    @test flip_matrix([1 1 0; 1 0 1; 0 0 0]) == [1 0 0; 0 1 0; 1 1 1]
    @test flip_matrix([1 1 0 0; 1 0 0 1; 0 1 1 1; 1 0 1 0]) ==
          [1 1 0 0; 0 1 1 0; 0 0 0 1; 1 0 1 0]
end
