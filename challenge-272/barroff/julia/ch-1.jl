#!/usr/bin/env julia

using Test: @test, @testset

function defang_ip_address(ip::AbstractString)::String
	replace(ip, "." => "[.]")
end

@testset "defang IP address" begin
	@test defang_ip_address("1.1.1.1") == "1[.]1[.]1[.]1"
	@test defang_ip_address("255.101.1.0") == "255[.]101[.]1[.]0"
end
