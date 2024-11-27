#!/usr/bin/env julia

using Test: @test, @testset

function word_break(str::String, words::Vector{String})::Bool
    if str in words
    return true
    end
    starters = filter(x -> startswith(str, x), words)
if length(starters) > 0
    l = map(x -> word_break(str[length(x) + 1:end], words), starters)
return any(l)
    end
    return false
end

@testset "word break" begin
    @test word_break("weeklychallenge", ["challenge", "weekly"])
    @test word_break("perlrakuperl", ["raku", "perl"])
    @test word_break("sonsanddaughters", ["sons", "sand", "daughters"]) == false
end

