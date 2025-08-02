#!/usr/bin/env julia

using Test: @test, @testset

function three_power(n::T) where {T<:Integer}
    power_set = Set([x^3 for x = 0:ceil(sqrt(n))])
    return n in power_set
end

@testset "three power" begin
    @test three_power(27) == true
    @test three_power(0) == true
    @test three_power(6) == false
end
