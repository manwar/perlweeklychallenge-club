#!ruby.exe

require 'prime'

# AUTHOR: Robert DiCicco
# DATE: 6-APR-2022
# Challenge 159 Moebius Number ( Ruby )

def prime_factorization(n)
  Prime.prime_division(n).flat_map { |factor, power| [factor] * power }
end

def checkSquareFree(n)
  Prime.prime_division(n).each do |i|
    if i[1] > 1
      return 0
    end
  end

  return 1
end

def getPrimeFactorCount(n)
  a = prime_factorization(n)
  x = a.size % 2

  if x == 0
    return 1
  else
    return 0
 end
end

def showResults(pf,sf)
  if ((pf == 1) && (sf == 1))
    print("Output: 1\n")
  elsif ((pf == 0) && (sf == 1))
    print("Output: -1\n")
  elsif ( sf == 0 )
    print("Output: 0\n")
  else
    print("Error!!!\n")
  end
end

n = ARGV[0].to_i

print("Input: #{n}\n")

sf = checkSquareFree(n)
pf = getPrimeFactorCount(n)

showResults(pf,sf)
