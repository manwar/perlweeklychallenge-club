#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2023-01-02

Challenge 198 Prime Count ( Julia )

=#

using Printf

using Primes

 

arr = [10,15,1,25]

 

for n in arr

                cnt = 0

                @printf("Input: \$n = %d\n",n)

                for x in 1:n

                                if isprime(x)

                                                cnt += 1

                                end

                end

                @printf("Output: %d\n\n",cnt)

end

#=

julia .\PrimeCount.jl

Input: $n = 10

Output: 4

 

Input: $n = 15

Output: 6

 

Input: $n = 1

Output: 0

 

Input: $n = 25

Output: 9

=#
