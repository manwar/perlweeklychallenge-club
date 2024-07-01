#!/usr/bin/env julia

using Test: @test, @testset

function broken_keys(str::AbstractString, keys::Vector{Char})::Int
    keys_set = Set(map(x -> lowercase(string(x)), keys))
    length(
        filter(
            x -> isempty(intersect(Set(split(lowercase(x), "")), keys_set)),
            split(str)
        )
    )
end

@testset "broken keys" begin
    @test broken_keys("Perl Weekly Challenge", ['l', 'a']) == 0
    @test broken_keys("Perl and Raku", ['a']) == 1
    @test broken_keys("Well done Team PWC", ['l', 'o']) == 2
    @test broken_keys("The joys of polyglottism", ['T']) == 2
end
