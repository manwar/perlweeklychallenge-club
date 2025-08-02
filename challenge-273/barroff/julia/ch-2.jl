#!/usr/bin/env julia

using Test: @test, @testset

function b_after_a(str::AbstractString)::Bool
	occursin(r"^a*b+$", str) ? true : false
end

@testset "b after a" begin
    @test b_after_a("aabb") == true
    @test b_after_a("abab") == false
    @test b_after_a("aaa") == false
    @test b_after_a("bbb") == true
end
