#!/usr/bin/env julia

using Test: @test, @testset

function reverse_word(word::AbstractString, chr::Char)::String
    if contains(word, chr)
        char_pos = findfirst(chr, word)
        return join(sort(split(word[1:char_pos], ""))) * word[(char_pos + 1):end]
    else
        return word
    end
end

@testset "reverse word" begin
    @test reverse_word("challenge", 'e') == "acehllnge"
    @test reverse_word("programming", 'a') == "agoprrmming"
    @test reverse_word("champion", 'b') == "champion"
end
