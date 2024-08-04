#!/usr/bin/env julia

using Test: @test, @testset

function twice_appearance(str::AbstractString)::Char
    str_set = Set{Char}()
    for c in str
        if in(c, str_set)
            return c
        end
        push!(str_set, c)
    end
end

@testset "twice appearance" begin
    @test twice_appearance("acbddbca") == 'd'
    @test twice_appearance("abccd") == 'c'
    @test twice_appearance("abcdabbb") == 'a'
end
