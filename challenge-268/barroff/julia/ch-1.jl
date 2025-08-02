#!/usr/bin/env julia

using Test: @test, @testset

function magic_number(x::Vector{T}, y::Vector{T})::Int where {T<:Integer}
    return abs(minimum(x) - minimum(y))

end

@testset "magic number" begin
    @test magic_number([3, 7, 5], [9, 5, 7]) == 2
    @test magic_number([1, 2, 1], [5, 4, 4]) == 3
    @test magic_number([2], [5]) == 3
end

