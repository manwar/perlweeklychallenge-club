#!/usr/bin/env julia

using Test: @test, @testset

function count_even_digits_number(ints::Vector{T}) where {T<:Integer}
	length(filter(x -> lastindex("$x") % 2 == 0, ints))
end

@testset "count even digits number" begin
	@test count_even_digits_number([10, 1, 111, 24, 1000]) == 3
	@test count_even_digits_number([111, 1, 11111]) == 0
	@test count_even_digits_number([2, 8, 1024, 256]) == 1
end

