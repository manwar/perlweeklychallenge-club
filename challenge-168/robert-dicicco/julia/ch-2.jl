#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-06-07
# Challenge 168 Home Primes ( Julia )

using Primes

results = []

function homeprime( hp )

  temp = []

  s = " "

  temp = factor(Array, hp)

  for i in 1:length(temp)

    s = s * repr(temp[i])

  end

  return(parse(Int64, s))

end

hp = 8

flag = 1

push!(results,hp)

while flag > 0

  retval = homeprime(hp)

  push!(results,retval)

  isprime(retval) ? (global flag = 0) : (global hp = retval)

end

println(results)
