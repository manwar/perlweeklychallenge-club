#!/usr/bin/env julia

using Test: @test, @testset

function sort_letters(letters::Vector{Char}, weights::Vector{Int})::String
    ldict = Dict([z[2] => z[1] for z in zip(letters, weights)])
    return join([ldict[i] for i = 1:length(weights)])
end

@testset "sort letters" begin
    @test sort_letters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]) == "PERL"
    @test sort_letters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]) == "RAKU"
    @test sort_letters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]) == "PYTHON"
end
