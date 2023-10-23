#!/usr/bin/env julia

using Test: @test, @testset

function consistent_strings(allowed::String, words::Vector{String})
	splitted_words = map(x -> split(x, ""), words)
	characer_sets = map(x -> Set(x), splitted_words)
	allowed_chars = Set(split(allowed, ""))
	return length(filter(x -> x ⊆ allowed_chars, characer_sets))
end

@testset "consistent strings" begin
	@test consistent_strings("ab", ["ad", "bd", "aaab", "baa", "badab"]) == 2
	@test consistent_strings("abc", ["a", "b", "c", "ab", "ac", "bc", "abc"]) == 7
	@test consistent_strings("cad", ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]) == 4
end
