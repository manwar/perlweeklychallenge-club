#!/usr/bin/env julia

using Test: @test, @testset

function acronym(chk::String, str::Vector{String})
	return lowercase(chk) == join(map(x -> lowercase(x)[1], str))
end

@testset "acronym" begin
	@test acronym("ppp", ["Perl", "Python", "Pascal"]) == true
	@test acronym("rp", ["Perl", "Raku"]) == false
	@test acronym("oac", ["Oracle", "Awk", "C"]) == true
end
