#!/usr/bin/env julia

using Test: @test, @testset

function two_out_of_three(array1::Array{Int}, array2::Array{Int}, array3::Array{Int})
	set1 = Set{Int}(array1)
	set2 = Set{Int}(array2)
	set3 = Set{Int}(array3)
	return (set1 ∩ set2) ∪ (set1 ∩ set3) ∪ (set2 ∪ set3)
end

@testset "two out of three" begin
	@test two_out_of_three([1, 1, 2, 4], [2, 4], [4]) == Set{Int}([ 2, 4 ])
	@test two_out_of_three([4, 1], [2, 4], [1, 2]) == Set{Int}([ 1, 2, 4 ])
end
