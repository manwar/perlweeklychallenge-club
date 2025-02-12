#!/usr/bin/env julia

using Test: @test, @testset

function find_anagrams(words::Vector{String})::Int
    cleanedWords = [join(sort(collect(x))) for x in words]
    return count(x -> cleanedWords[x] != cleanedWords[x+1], 1:length(words)-1) + 1
end

@testset "find anagrams" begin
    @test find_anagrams(["acca", "dog", "god", "perl", "repl"]) == 3
    @test find_anagrams(["abba", "baba", "aabb", "ab", "ab"]) == 2
end
