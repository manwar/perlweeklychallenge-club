#!/usr/bin/env julia

using Test: @test, @testset

function complete_day(hours::Vector{T})::Int where {T<:Integer}
    length(
        filter(
            x -> x % 24 == 0,
            [hours[x] + hours[y] for x in 1:length(hours)-1 for y in x+1:length(hours)]
        )
    )
end

@testset "complete day" begin
    @test complete_day([12, 12, 30, 24, 24]) == 2
    @test complete_day([72, 48, 24, 5]) == 3
    @test complete_day([12, 18, 24]) == 0
end
