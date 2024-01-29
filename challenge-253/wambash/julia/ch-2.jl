#!/usr/bin/env julia

using Lazy

weakest_row(matrix) = @>> begin
    matrix
    pairs
    collect
    map(reverse)
    sort
    map(x-> x.second - 1)
end

using Test

@testset "Matrix" begin
    matrix = [
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 1]
    ]
    @test weakest_row(matrix) == [2,0,3,1,4]
end

@testset "Matrix with same rows" begin
    matrix = [
        [1, 0, 0, 0],
        [1, 1, 1, 1],
        [1, 0, 0, 0],
        [1, 0, 0, 0],
    ]
    @test weakest_row(matrix) == [0,2,3,1]
end
