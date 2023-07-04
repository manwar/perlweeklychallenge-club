#!/usr/bin/env julia
#=
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-26
Challenge 223 Task 1 Count Primes ( Julia )
-----------------------------------------
=#
using Printf
using Primes

input_n = [10,1,20]

for n in input_n
    @printf("Input: \$n = %d\n", n)
    num = 0
    cnt = 0
    while num < n
        if isprime(num)
            cnt += 1
        end
        num += 1
    end
    @printf("Output: %d\n\n",cnt)
end

#=
-----------------------------------------
SAMPLE OUTPUT
julia .\CountPrimes.jl

Input: $n = 10
Output: 4

Input: $n = 1
Output: 0

Input: $n = 20
Output: 8
-----------------------------------------
=#


