#!/usr/bin/env julia

using Test: @test, @testset

function check_color(str::AbstractString)::Bool
    (Int(str[1]) + parse(Int, str[2])) % 2 != 0
end

@testset "check color" begin
    @test check_color("d3") == true
    @test check_color("g5") == false
    @test check_color("e6") == true
end
