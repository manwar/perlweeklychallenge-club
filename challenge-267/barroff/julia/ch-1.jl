#!/usr/bin/env julia

using Test: @test, @testset

function product_sign(ints::Vector{T})::Int where {T<:Integer}
	if 0 in ints
		return 0
	end
	return length(filter(x -> x < 0, ints)) % 2 == 0 ? 1 : -1

end

@testset "product sign" begin
    @test product_sign([-1, -2, -3, -4, 3, 2, 1]) == 1
    @test product_sign([1, 2, 0, -2, -1]) == 0
    @test product_sign([-1, -1, 1, -1, 2]) == -1
end
