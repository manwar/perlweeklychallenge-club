#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

const Primes = [
  2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79,
  83, 89, 97
]

proc isPrime(n: int): bool =
  if n == 2 or n == 3:
    return true
  elif n mod 3 == 0 or n mod 2 == 0:
    return false

  for i in 5 .. sqrt(n.float).int:
    if n mod i == 0:
      return false
  true

proc smallestNonPrimeEuclidNumber(): int =
  var product = 1
  for i, prime in Primes:
    product = product * prime
    let euclidNumber = product + 1
    if not euclidNumber.isPrime:
      return euclidNumber

when isMainModule:
  import std/unittest

  suite "Smallest non-prime Euclid number":
    test "smalles nonprime euclid number is 30031":
      check smallestNonPrimeEuclidNumber() == 30031
