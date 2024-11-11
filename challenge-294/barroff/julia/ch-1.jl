#!/usr/bin/env julia

using Test: @test, @testset

function consecutive_sequence(ints::Vector{T})::Int where {T<:Integer}
    (mn, mx) = extrema(ints)
    spots = falses(mx + 1 - mn)
    map(x -> spots[x+1-mn] = 1, ints)
    longestSeq = 1
    currentSeq = 0
    for x in spots
        if x == 1
            currentSeq += 1
        elseif currentSeq != 0
            longestSeq = max(longestSeq, currentSeq)
            currentSeq = 0
        end
    end
    longestSeq = max(longestSeq, currentSeq)
    return longestSeq == 1 ? -1 : longestSeq
end

@testset "consecutive sequence" begin
    @test consecutive_sequence([10, 4, 20, 1, 3, 2]) == 4
    @test consecutive_sequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]) == 9
    @test consecutive_sequence([10, 20, 30]) == -1
end
