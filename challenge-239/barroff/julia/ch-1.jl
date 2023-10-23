#!/usr/bin/env julia

using Test: @test, @testset

function same_string(arr1::Vector{String}, arr2::Vector{String})
	return join(arr1, "") == join(arr2, "")
end

@testset "same string" begin
	@test same_string(["ab", "c"], ["a", "bc"]) == true
	@test same_string(["ab", "c"], ["ac", "b"]) == false
	@test same_string(["ab", "cd", "e"], ["abcde"]) == true
end
