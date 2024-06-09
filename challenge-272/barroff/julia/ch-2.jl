#!/usr/bin/env julia

using Test: @test, @testset

function string_score(str::AbstractString)::Int
	sum([abs(str[i] - str[i + 1]) for i in 1:lastindex(str) - 1])
end

@testset "string score" begin
	@test string_score("hello") == 13
	@test string_score("perl") == 30
	@test string_score("raku") == 37
end
