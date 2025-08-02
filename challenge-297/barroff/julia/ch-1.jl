#!/usr/bin/env julia

using Test: @test, @testset

function contiguous_array(binary::Vector{Int})::Int
    s = sum(binary)
    s = min(s, length(binary) - s)
    for i in s:-1:1
        j = 2 * i - 1
        for k in 1:length(binary)-j
            if sum(binary[k:k+j]) == i
                return 2 * i
            end
        end
    end
    return 0
end

@testset "contiguous array" begin
    @test contiguous_array([1, 0]) == 2
    @test contiguous_array([0, 1, 0]) == 2
    @test contiguous_array([0, 0, 0, 0, 0]) == 0
    @test contiguous_array([0, 1, 0, 0, 1, 0]) == 4
end
