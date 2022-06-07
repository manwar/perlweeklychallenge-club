#!ruby.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-06-06
# Challenge 168 Perrin Primes ( Ruby )

require 'prime'

perrin = Array[3,0,2]

PRIME_COUNT = 14

results = Array.new()

i = 0

while i < PRIME_COUNT

  slots = perrin.length()

  calc_val = perrin[slots - 2] + perrin[slots - 3]

  perrin.push(calc_val)

  if Prime.prime?(calc_val)

    results.push(calc_val)

    i += 1

  end

end

results = results.sort.uniq

puts "#{results }"
