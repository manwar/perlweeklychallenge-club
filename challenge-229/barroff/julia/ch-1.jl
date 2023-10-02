#!/usr/bin/env julia

using Test: @test, @testset

function is_lexicographic(word::String)
	sorted_word = join(sort(split(word, "")))
	return (sorted_word == word) || (reverse(sorted_word) == word)
end

function lexicographic_order(words::Array{String})
	return length(filter(x -> !(is_lexicographic(x)), words))
end

function lexicographic_order(words...)
	return length(filter(x -> !(is_lexicographic(x)), words))
end

@testset "lexicographic order" begin
	@test lexicographic_order(["abc", "bce", "cae"]) == 1
	@test lexicographic_order(["yxz", "cba", "mon"]) == 2
	@test lexicographic_order("abc", "bce", "cae") == 1
	@test lexicographic_order("yxz", "cba", "mon") == 2
end
