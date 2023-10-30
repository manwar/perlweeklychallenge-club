#!/usr/bin/env julia

using Test: @test, @testset

function common_characters(words)
	splitted_words = map(x -> split(x, ""), words)
	characer_sets = map(x -> Set(x), splitted_words)
	common_chars = reduce(intersect, characer_sets)
	result = ""
	for i in common_chars
		result *= i ^ minimum(map(x -> count(y -> y == i, x), splitted_words))
	end
	return split(result, "")
end

@testset "common characters" begin
	@test common_characters(["java", "javascript", "julia"]) == ["j", "a"]
	@test common_characters(["bella", "label", "roller"])    == ["e", "l", "l"]
	@test common_characters(["cool", "lock", "cook"])        == ["c", "o"]
end
