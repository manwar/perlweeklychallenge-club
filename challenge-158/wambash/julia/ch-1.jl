#!/usr/bin/env julia
using Lazy

sum_of_digits_is_prime(n) =  n |> digits |> sum |> Lazy.isprime

additive_primes( n::Integer=100 ) = @>> begin
    Lazy.range(2)
    filter( Lazy.isprime )
    filter( sum_of_digits_is_prime )
    takewhile( x -> x ≤ n )
end

function MAIN( n )
    additive_primes(n) .|> println
end

using Test

function TEST()
    @testset "additive primes" begin
        @test additive_primes() == list(2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89,)
        @test additive_primes(12) == list(2, 3, 5, 7, 11,)
    end
end


using ArgParse

s = ArgParseSettings()

@add_arg_table! s begin
    "--test"
    action = :store_true
    "n"
    arg_type = Int
    default = 100
end

pa=parse_args(s)

if pa["test"]
    TEST()
else
    MAIN(pa["n"])
end
