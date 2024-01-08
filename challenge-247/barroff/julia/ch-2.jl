#!/usr/bin/env julia

using Test: @test, @testset

function most_frequent_letter_pair(s::S) where {S<: AbstractString}
	letterPairs = map(x -> s[x:x+1], 1:lastindex(s) - 1)
	pos_dict = Dict{String,Integer}()
	map(x -> haskey(pos_dict, x) ? pos_dict[x] += 1 : pos_dict[x] = 1, letterPairs)
	max_repetitions = maximum(values(pos_dict))
	return sort(filter(x -> pos_dict[x] == max_repetitions, collect(keys(pos_dict))))[1]
end

@testset "reverse pairs" begin
	@test most_frequent_letter_pair("abcdbca") == "bc"
	@test most_frequent_letter_pair("cdeabeabfcdfabgcd") == "ab"
end

