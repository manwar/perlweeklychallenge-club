#!/usr/bin/env julia

using Test: @test, @testset

function cw(word::AbstractString, words::Vector{String})::String
    hits = filter(w -> startswith(word, w), words)
    if length(hits) > 0
        return hits[1]
    else
        return word
    end
end

function replace_words(sentence::String, words::Vector{String})::String
    return join(
        map(
            w -> cw(w, words),
            split(sentence, ' ')
        ),
        ' '
    )
end

@testset "replace words" begin
    @test replace_words("the cattle was rattle by the battery", ["cat", "bat", "rat"]) == "the cat was rat by the bat"
    @test replace_words("aab aac and cac bab", ["a", "b", "c"]) == "a a a c b"
    @test replace_words("the manager was hit by a biker", ["man", "bike"]) == "the man was hit by a bike"
end

