#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc primeSieve(max: int): seq[int] =
  var sieve = newSeq[bool](max+1)
  sieve[0..1] = [true, true]

  for p in 2..sieve.high:
    if sieve[p]: continue
    for m in countup(p+p, sieve.high, p):
      sieve[m] = true

  for i in 2..sieve.high:
    if not sieve[i]: result.add i

proc primeFactors(number: int): seq[int] =
  var number = number

  let primes = primeSieve(100)
  var facInd = 0

  while number > 1:
    while number mod primes[facInd] != 0:
      inc facInd
    number = number div primes[facInd]
    result.add primes[facInd]

proc attractiveNumbersBetween1and50: seq[int] =
  let primes = primeSieve(100)
  for n in 2..<50:
    if primeFactors(n).len in primes:
      result.add n

when isMainModule:
  import std/unittest

  const
    Expected = [
      4, 6, 8, 9, 10, 12, 14, 15, 18, 20, 21, 22, 25, 26, 27, 28, 30, 32, 33,
      34, 35, 38, 39, 42, 44, 45, 46, 48, 49
    ]

  suite "Attractive Numbers":
    test "Numbers with a prime number of prime divisors between 1 and 50":
      check attractiveNumbersBetween1and50() == Expected

