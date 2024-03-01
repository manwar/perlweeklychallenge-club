#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

proc primeSieve(max: int): seq[int] =
  var sieve = newSeq[bool](max)

  for p in 2 .. sieve.high:
    if sieve[p]:
      continue

    for i in countUp(2 * p, sieve.high, p):
      sieve[i] = true

  for i, notPrime in sieve[2 ..^ 1]:
    if not notPrime:
      result.add i + 2

proc tierPrimesByStrength(
    primes: openArray[int]
): tuple[weak, balanced, strong: seq[int]] =
  for pInd, prime in primes[0 ..^ 2]:
    if pInd == 0:
      continue
    let mean = (primes[pInd - 1] + primes[pInd + 1]) / 2

    if almostEqual(prime.float, mean):
      result.balanced.add prime
    elif prime.float > mean:
      result.strong.add prime
    elif prime.float < mean:
      result.weak.add prime
    else:
      raiseAssert("Error: bad float comparison.")

when isMainModule:
  import std/unittest

  const
    ExpectedWeak = [3, 7, 13, 19, 23, 31, 43, 47, 61, 73]
    ExpectedStrong = [11, 17, 29, 37, 41, 59, 67, 71, 79, 97]

  suite "Strong and weak primes":
    let (weak, _, strong) = tierPrimesByStrength(primeSieve(200))

    test "first 10 weak primes":
      check weak[0 ..< 10] == ExpectedWeak
    test "first 10 strong primes":
      check strong[0 ..< 10] == ExpectedStrong
