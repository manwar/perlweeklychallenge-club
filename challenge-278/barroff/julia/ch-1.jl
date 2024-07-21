#!/usr/bin/env julia

using Test: @test, @testset

function sort_string(str::AbstractString)::String
    str_dict = Dict{Int,String}()
    map(x -> str_dict[parse(Int, x[end])] = x[1:end-1], split(str))
    return join(map(x -> str_dict[x], 1:length(str_dict)), " ")
end

@testset "sort string" begin
    @test sort_string("and2 Raku3 cousins5 Perl1 are4") ==
          "Perl and Raku are cousins"
    @test sort_string("guest6 Python1 most4 the3 popular5 is2 language7") ==
          "Python is the most popular guest language"
    @test sort_string("Challenge3 The1 Weekly2") == "The Weekly Challenge"
end
