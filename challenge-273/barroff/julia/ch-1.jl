#!/usr/bin/env julia

using Test: @test, @testset

function percentage_of_character(str::AbstractString, char::Char)::Int
    if char in str
        ceil(Int, 100 * count(x -> x == char, str) / lastindex(str))
    else
        return 0
    end
end

@testset "percentage of character" begin
    @test percentage_of_character("perl", 'e') == 25
    @test percentage_of_character("java", 'a') == 50
    @test percentage_of_character("python", 'm') == 0
    @test percentage_of_character("ada", 'a') == 67
    @test percentage_of_character("ballerina", 'l') == 23
    @test percentage_of_character("analitik", 'k') == 13
end
