#!/usr/bin/env julia

using Test: @test, @testset

function count_words(words::Array{String}, prefix::String)
	return length(filter(x -> prefix == x[1:lastindex(prefix)], words))
end

@testset "lexicographic order" begin
	@test count_words(["pay", "attention", "practice", "attend"], "at") == 2
	@test count_words(["janet", "julia", "java", "javascript"], "ja") == 3
end

