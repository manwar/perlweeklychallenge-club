#!/usr/bin/env julia

using Test: @test, @testset

function greates_english_letter(str::String)::String
	str_set = Set(str)
	candidates = sort([
			uppercase(x) for x in
			filter(
				x -> lowercase(x) ∈ str_set && uppercase(x) ∈ str_set,
				str_set
			)]
	)
	if length(candidates) > 0
		return "$(candidates[end])"
	end
	return ""
end

@testset "target index" begin
	@test greates_english_letter("PeRlwEeKLy") == "L"
	@test greates_english_letter("ChaLlenge") == "L"
	@test greates_english_letter("The") == ""
end
