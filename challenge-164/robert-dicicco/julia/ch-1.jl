#!julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-05-09
# Challengr #164 Prime Palindrome ( Julia )

using Primes
using Printf

for n in 1:1000
  if (isprime(n))
    n_rev = parse(Int,reverse(string(n)))
    if( n == n_rev )
      @printf("%d ",n)
    end
  end
end

println()
