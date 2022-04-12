#!julia.exe

using Printf
using Primes

# AUTHOR: Robert DiCicco
# DATE: 29-MAR-2022
# Challenge 158 Additive Primes ( Julia )

function sumOfDigits(i)

  d = digits(i)     # break into digits
  s = sum(d)        # sum them

  if isprime(s)     # return number if sum is prime
    return i
  else
    return -1       # else return neg number
  end

end

function main()

  TARGET = 100
  i = 1

  while i < TARGET
    dsum = sumOfDigits(i)

    if isprime(dsum)      # print it if prime
      @printf("%d ",i)
    end

    i += 1
  end

  print("\n")
end

main()
