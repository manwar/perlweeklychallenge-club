#!/usr/bin/env julia

using Test: @test, @testset

function extract_age(s::AbstractString)
	return match(r"\d{10}[A-Z](\d\d)\d\d", s).captures[1]
end

function s_to_i(x::AbstractString)
	return parse(Int64, x)
end

function senior_citizen(passengers::Array{String})
	length(filter(x -> x >= 60, s_to_i.(extract_age.(passengers))))
end

@testset "senior citizen" begin
    @test senior_citizen([ "7868190130M7522", "5303914400F9211", "9273338290F4010" ]) == 2
	@test senior_citizen([ "1313579440F2036", "2921522980M5644" ]) == 0
end
