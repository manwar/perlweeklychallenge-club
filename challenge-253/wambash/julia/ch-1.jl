#!/usr/bin/env julia

split_strings(words; separator = " " ) = mapreduce( x -> split(x, separator, keepempty=false ), vcat,  words)

using Test

@testset "split strings" begin
    @test split_strings(["one.two.three","four.five","six"], separator = ".") == ["one","two","three","four","five","six"]
    @test split_strings(["\$perl\$\$", "\$\$raku\$"], separator = "\$") == ["perl","raku"]
end
