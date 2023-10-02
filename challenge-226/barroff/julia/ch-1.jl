#!/usr/bin/env julia

using Test: @test, @testset

function shuffle_string(strng::String, ints::Array{Int})
    shuffle_dict = Dict{Integer,String}(x => y for (x, y) in zip(ints, split(strng, "")))
    return join([shuffle_dict[x] for x in collect(0:maximum(ints))], "")
end

@testset "shuffle string" begin
    @test shuffle_string("lacelengh", [3, 2, 0, 5, 4, 8, 6, 7, 1]) == "challenge"
    @test shuffle_string("rulepark", [4, 7, 3, 1, 0, 5, 2, 6]) == "perlraku"
end

