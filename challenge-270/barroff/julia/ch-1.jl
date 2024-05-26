#!/usr/bin/env julia

using Test: @test, @testset

function special_positions(m::Matrix{T})::Int where {T<:Integer}
    special_columns = filter(x -> sum(m[:, x]) == 1, 1:size(m, 2))
    return length(
        filter(
            x -> sum(m[x, :]) == 1,
            map(
                x -> findfirst(
                    y -> y == 1,
                    m[:, x]
                ), special_columns)
        )
    )
end

@testset "special positions" begin
    @test special_positions(
        [1 0 0;
            0 0 1;
            1 0 0
        ]) == 1
    @test special_positions(
        [1 0 0;
            0 1 0;
            0 0 1
        ]) == 3
end
