#!/usr/bin/env julia

using Test: @test, @testset

function split_string(str::AbstractString)::Bool
    vowels = Set(['a', 'e', 'i', 'o', 'u'])
    count(x -> x in vowels, collect(str)) % 2 == 0
end

@testset "split string" begin
    @test split_string("perl") == false
    @test split_string("book") == true
    @test split_string("good morning") == true
end
