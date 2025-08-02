#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc primeSieve(max: int): seq[int] =
  var sieve = newSeq[bool](max)

  for p in 2 .. sieve.high:
    if sieve[p]:
      continue

    for i in countUp(2 * p, sieve.high, p):
      sieve[i] = true

  for i, notPrime in sieve.toOpenArray(2, sieve.high):
    if not notPrime:
      result.add i + 2

proc primeDecomposition(n: int): seq[int] =
  let primes = primeSieve(n)

  var number = n
  var pInd = 0
  while number > 1:
    let prime = primes[pInd]
    if number mod prime == 0:
      result.add prime
      number = number div prime
    else:
      inc pInd

when isMainModule:
  import std/unittest

  const
    Test = 228
    Expected = [2,2,3,19]

  suite "Prime decomposition":
    test "decomposition of 228 is 2,2,3,19":
      check Test.primeDecomposition() == Expected
