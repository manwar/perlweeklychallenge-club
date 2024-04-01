#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc primeSieve(max: int): seq[int] =
  var notPrimes = newSeq[bool](max + 1)
  for i in 2 .. max:
    if notPrimes[i]:
      continue
    for j in countUp(2 * i, max, i):
      notPrimes[j] = true

  for i, notPrime in notPrimes:
    if i < 2:
      continue
    if not notPrime:
      result.add i

proc sexyPrimePairs(max, count: int): seq[(int, int)] =
  let primes = primeSieve(max)
  for pi, prime in primes:
    if result.len >= count:
      break

    var pairInd = pi + 1
    while primes[pairInd] - prime < 6:
      inc pairInd

    if primes[pairInd] - prime == 6:
      result.add (prime, primes[pairInd])

when isMainModule:
  import std/unittest

  const Expected = [
    (5, 11),
    (7, 13),
    (11, 17),
    (13, 19),
    (17, 23),
    (23, 29),
    (31, 37),
    (37, 43),
    (41, 47),
    (47, 53),
  ]

  suite "Sexy prime pairs":
    test "first 10 pairs":
      check sexyPrimePairs(max = 100, count = 10) == Expected
