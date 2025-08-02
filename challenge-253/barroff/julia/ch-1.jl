#!/usr/bin/env julia

using Test: @test, @testset

function split_strings(separator::Char, words::Vector{T}) where {T<:AbstractString}
    return collect(
        Iterators.flatten([
            filter(x -> lastindex(x) > 0, x) for x in map(x -> split(x, separator), words)
        ]),
    )
end

@testset "split strings" begin
    @test split_strings('.', ["one.two.three", "four.five", "six"]) ==
          ["one", "two", "three", "four", "five", "six"]
    @test split_strings('$', [raw"$perl$$", raw"$$raku$"]) == ["perl", "raku"]
end
