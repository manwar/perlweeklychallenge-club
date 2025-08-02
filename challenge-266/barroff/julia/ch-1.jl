#!/usr/bin/env julia

using Test: @test, @testset

function common_words(sentence1::String, sentence2::String)::Set{String}
    word_counts = Dict{String,Int}()
    map(x -> haskey(word_counts, x) ? word_counts[x] += 1 : word_counts[x] = 1, split(sentence1))
    map(x -> haskey(word_counts, x) ? word_counts[x] += 1 : word_counts[x] = 1, split(sentence2))
	result = filter(x -> word_counts[x] == 1, keys(word_counts))
	return length(result) > 0 ? result : Set([""])

end

@testset "common words" begin
	@test common_words("Mango is sweet", "Mango is sour") == Set(["sweet", "sour"])
	@test common_words("Mango Mango", "Orange") == Set(["Orange"])
	@test common_words("Mango is Mango", "Orange is Orange") == Set([""])
end
