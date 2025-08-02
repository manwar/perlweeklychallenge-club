#!/usr/bin/env julia

using Test: @test, @testset

function lucky_integer(ints::Vector{T})::Int where {T<:Integer}
    int_dict = Dict{Int,Int}()
    map(x -> int_dict[x] =  get(int_dict, x, 0) + 1, ints)
    lucky_numbers = filter(x -> int_dict[x] == x, keys(int_dict))
    return length(lucky_numbers) > 0 ? maximum(lucky_numbers) : -1
end

@testset "lucky integer" begin
    @test lucky_integer([2, 2, 3, 4]) == 2
    @test lucky_integer([1, 2, 2, 3, 3, 3]) == 3
    @test lucky_integer([1, 1, 1, 3]) == -1
end
