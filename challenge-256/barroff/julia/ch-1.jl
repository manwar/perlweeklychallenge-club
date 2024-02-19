#!/usr/bin/env julia

using Test: @test, @testset

function maximum_pairs(words::Vector{T})::Int64 where {T<:AbstractString}
	non_palindromes = filter(x -> x != reverse(x), words)
	word_set = Set(non_palindromes)
	reversed_word_set = Set([reverse(s) for s in non_palindromes])
	length(intersect(word_set, reversed_word_set)) / 2
end

@testset "maximum pairs" begin
	@test maximum_pairs(["ab", "de", "ed", "bc"]) == 1
	@test maximum_pairs(["aa", "ba", "cd", "ed"]) == 0
	@test maximum_pairs(["uv", "qp", "st", "vu", "mn", "pq"]) == 2
end

