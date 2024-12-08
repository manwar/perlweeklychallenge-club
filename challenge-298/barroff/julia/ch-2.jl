#!/usr/bin/env julia

using Test: @test, @testset

function right_interval(intervals::Vector{Vector{Int}})::Vector{Int}
    rp::Int = 0
    result = Vector{Int}(undef, length(intervals))
    for i in 1:length(intervals)
        rp = 0
        for j in 1:length(intervals)
            if intervals[j][1] == intervals[i][2]
                rp = j
                break
            end
            if intervals[j][1] > intervals[i][2]
                if rp == -1
                    rp = j
                elseif intervals[j][1] < intervals[i][1]
                    rp = j
                end
            end
        end
        result[i] = rp - 1
    end
    return result
end

@testset "right interval" begin
    @test right_interval([[3, 4], [2, 3], [1, 2]]) == [-1, 0, 1]
    @test right_interval([[1, 4], [2, 3], [3, 4]]) == [-1, 2, -1]
    @test right_interval([[1, 2]]) == [-1]
    @test right_interval([[1, 4], [2, 2], [3, 4]]) == [-1, 1, -1]
end
