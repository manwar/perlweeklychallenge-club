#julia.exe

# AUTHOR: Robert DiCicco
# DATE: 2022-08-09
# Challenge 177 Palindromic Prime Cyclops ( Julia )

using Printf
using Primes

function MidChar( str )

  s = string(str)

  if length(s) == 3

    return s[2]

  elseif length(s) == 5

    return s[3]

  elseif length(s) == 7

    return s[4]

  end

end

function main()

  count = 0

  candidate = 100

  while count <= 20

    s = string(candidate)

    if ! iseven(candidate) && isprime(candidate) && s == reverse(s) && MidChar(candidate) == '0'

      print("$candidate ")

      count += 1

    end

    candidate += 1

  end

end

main()
