#!julia.exe

using Printf
using Primes

# AUTHOR: Robert DiCicco
# DATE: 6-APR-2022
# Challenge 159 Moebius Number ( Julia )

const sqprimes = map(x -> x * x, primes(2, 100))
possdivisorsfor(n) = vcat(filter(x -> x <= n / 2, sqprimes), n in sqprimes ? n : [])
issquarefree(n) = all(x -> floor(n / x) != n / x, possdivisorsfor(n))

function checkArgs(args)
  global num
  try
    num = parse(Int64, args[1])
  catch
    println("Error: Argument must be an integer")
    exit(0)
  finally
    main(num)
  end
end

function getPrimeFactorCount(n)
  pf = factor(Array, n )
  sz = size(pf)
  cnt = mod(count(i->(i>0), pf),2)

  if cnt == 0
    return 1
  end

  return 0
end

function main(num)
  println("Input: $num")

  sf = issquarefree(num)

  if (sf)
    sf = 1
  else
    sf = 0
  end

  pfc = getPrimeFactorCount(num)

  if ((pfc == 1)  && (sf == 1))
    println("Output: 1\n")
  elseif ((pfc == 0) && (sf == 1))
    println("Output: -1\n")
  elseif ( sf == 0)
    println("Output: 0\n")
  else
    print("Error!!!\n")
  end

end

checkArgs(ARGS)
