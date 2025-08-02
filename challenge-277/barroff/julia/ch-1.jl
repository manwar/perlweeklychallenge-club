#!/usr/bin/env julia

using Test: @test, @testset

function count_common(words1::Vector{T}, words2::Vector{T})::Int where {T<:AbstractString}
    words1Dict = Dict{T,Int}()
    words2Dict = Dict{T,Int}()
    map(x -> words1Dict[x] = get(words1Dict, x, 0) + 1, words1)
    map(x -> words2Dict[x] = get(words2Dict, x, 0) + 1, words2)
    length(
        filter(
            x -> words1Dict[x] == 1 && get(words2Dict, x, 0) == 1,
            keys(words1Dict)
        )
    )
end

@testset "count common" begin
    @test count_common(
        ["Perl", "is", "my", "friend"],
        ["Perl", "and", "Raku", "are", "friend"],
    ) == 2
    @test count_common(
        ["Perl", "and", "Python", "are", "very", "similar"],
        ["Python", "is", "top", "in", "guest", "languages"],
    ) == 1
    @test count_common(
        ["Perl", "is", "imperative", "Lisp", "is", "functional"],
        ["Crystal", "is", "similar", "to", "Ruby"],
    ) == 0
end
