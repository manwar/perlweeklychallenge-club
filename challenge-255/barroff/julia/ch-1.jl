#!/usr/bin/env julia

using Test: @test, @testset

function odd_character(s::T, t::T) where {T<:AbstractString}
    sorted_s = sort(split(s, ""))
    sorted_t = sort(split(t, ""))
    for i in zip(sorted_s, sorted_t[1:end - 1])
        if i[1] != i[2]
            return i[2]
        end
    end
    return sorted_t[end]
end

@testset "odd character" begin
    @test odd_character("Perl", "Peerl") == "e"
    @test odd_character("Weekly", "Weeakly") == "a"
    @test odd_character("Box", "Boxy") == "y"
end
