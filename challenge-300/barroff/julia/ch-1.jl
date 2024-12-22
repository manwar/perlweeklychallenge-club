#!/usr/bin/env julia

using Test: @test, @testset

using Combinatorics

function is_beautiful(n::Int, i::Int)::Bool
    return n % i == 0 || i % n == 0
end

function check_arrangement(arrangement::Vector{Int})::Bool
    for (index, value) in enumerate(arrangement)
        if !is_beautiful(index, value)
            return false
        end
    end
    return true
end

function beautiful_arrangement(ba::Int)::Int
    perms = permutations(collect(1:ba))
    res = 0
    for perm in perms
        if check_arrangement(perm)
            res += 1
        end
    end
    return res
end

@testset "beatiful arrangement" begin
    @test beautiful_arrangement(2) == 2
    @test beautiful_arrangement(1) == 1
    @test beautiful_arrangement(10) == 700
    @test beautiful_arrangement(11) == 750
end

