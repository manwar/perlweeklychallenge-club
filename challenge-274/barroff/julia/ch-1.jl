#!/usr/bin/env julia

using Test: @test, @testset

function goat_latin(str::AbstractString)::String
    as = ""
    result = ""
    for word in split(str)
        as *= 'a'
        if lowercase(word[1]) in ['a', 'e', 'i', 'o', 'u']
            skip
        else
            word = word[2:end] * word[1]
        end
        result = result * " " * word * "ma" * as
    end
	return strip(result)
end

@testset "goat latin" begin
    @test goat_latin("I love Perl") == "Imaa ovelmaaa erlPmaaaa"
    @test goat_latin("Perl and Raku are friends") == "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
    @test goat_latin("The Weekly Challenge") == "heTmaa eeklyWmaaa hallengeCmaaaa"
end
