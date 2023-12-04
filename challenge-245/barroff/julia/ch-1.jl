#!/usr/bin/env julia

using Test: @test, @testset

function sort_language(lang::Vector{S}, positions::Vector{T}) where {S<: AbstractString, T<:Integer}
	pos_dict = Dict(zip(positions, lang)) 
	[pos_dict[x] for x in sort(positions)]
end

@testset "reverse pairs" begin
	@test sort_language(["perl", "c", "python"], [ 2, 1, 3 ]) == ["c", "perl", "python"]
	@test sort_language(["c++", "haskell", "java"], [ 1, 3, 2 ]) == ["c++", "java", "haskell"]
end
