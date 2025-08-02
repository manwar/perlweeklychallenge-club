#!/usr/bin/env julia

using Test: @test, @testset

function maximum_ones(m::Matrix{T})::Int where {T<:Integer}
	findmax(sum(m; dims=2))[1]
end

@testset "maximum ones" begin
    @test maximum_ones(
        [0 1;
            1 0
        ]) == 1
    @test maximum_ones(
        [0 0 0;
            1 0 1
        ]) == 2
    @test maximum_ones(
        [0 0;
            1 1;
            0 0
        ]) == 2
end
