#!/usr/bin/env julia

using Test: @test, @testset

function count_smaller(nums::Vector{T}) where {T<:Integer}
	positions = Dict(reverse(reverse.(enumerate(sort(nums))))) 
	[positions[x] - 1 for x in nums]
end

@testset "reverse pairs" begin
	@test count_smaller([8, 1, 2, 2, 3]) == [4, 0, 1, 1, 3]
	@test count_smaller([6, 5, 4, 8]) == [2, 1, 0, 3]
	@test count_smaller([2, 2, 2]) == [0, 0, 0]
end
