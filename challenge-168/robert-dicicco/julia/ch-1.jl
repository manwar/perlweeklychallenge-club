#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-06-06
# Challenge 168 Perrin Primes ( Julia )

using Primes

perrin = [3,0,2]

results = []

PRIME_COUNT = 13

i = 0

while i <= PRIME_COUNT

  slots = size(perrin,1)

  calc_val = perrin[slots - 1] + perrin[slots - 2]  # since julia arrays are option base 1

  push!(perrin,calc_val)

  if isprime(calc_val)

    push!(results,calc_val)

    global i += 1

  end

end

results = unique!(sort(results))

println(results)
