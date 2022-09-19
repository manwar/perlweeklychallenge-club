#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-07-06
# Challange 172 Prime Partition ( Julia )

using Primes
using Combinatorics

arr = []
b = []

function checkArgs(args)

  global m
  global n

  try
    m = parse(Int64, args[1])
    n = parse(Int64, args[2])
  catch
    println("Error: Argument must be an integer")
    exit(0)
  finally
    main(m,n)
  end

end

function main(m,n)
  for prm = 0:m
    if isprime(prm)
      push!(arr,prm)
    end
  end

  for combo in collect(combinations(arr,n))
    if(sum(combo) == m )
      println(combo)
    end
  end

end

checkArgs(ARGS)
