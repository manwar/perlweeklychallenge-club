#!/usr/bin/env julia

using Test: @test, @testset

function count_asterisks(str::AbstractString)::Int
    pairless = replace(str, r"\|.*?\|" => "")
    count(x -> x == '*', pairless)
end

@testset "count asterisks" begin
    @test count_asterisks("p|*e*rl|w**e|*ekly|") == 2
    @test count_asterisks("perl") == 0
    @test count_asterisks("th|ewe|e**|k|l***ych|alleng|e") == 5
end
