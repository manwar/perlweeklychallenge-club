#!/usr/bin/env julia

using Test: @test, @testset

function alphanumeric_string_value(alphanumstr::Vector{T}) where {T<:AbstractString}
    return maximum(
        map(x -> occursin(r"[a-zA-Z]", x) ? lastindex(x) : parse(Int, x), alphanumstr),
    )
end

@testset "alphanumeric string value" begin
    @test alphanumeric_string_value(["perl", "2", "000", "python", "r4ku"]) == 6
    @test alphanumeric_string_value(["001", "1", "000", "0001"]) == 1
end
