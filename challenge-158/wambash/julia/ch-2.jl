#!/usr/bin/env julia
using Lazy

first_series_cuban_primes(n=1000) = @>> begin
    Lazy.range()
    map( y -> 3y^2 + 3y+1 )
    filter(Lazy.isprime)
    takewhile( x -> x ≤ n )
end

function MAIN(n::Integer=1000)
    first_series_cuban_primes(n) .|> println
end

using Test

function TEST()
    @testset "Cuban primes" begin
        @test first_series_cuban_primes() == list(7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919.)
    end
end

using ArgParse

s = ArgParseSettings()

@add_arg_table! s begin
    "--test"
    action = :store_true
    "n"
    arg_type = Int
    default = 1000
end
pa=parse_args(s)

if pa["test"]
    TEST()
else
    MAIN(pa["n"])
end
