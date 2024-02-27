#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

proc fivePerfectNumbers(): array[5, int] =
  const Primes = [2, 3, 5, 7, 13]
  for i, p in Primes:
    result[i] = (2 ^ (p - 1)) * (2 ^ p - 1)

when isMainModule:
  import std/unittest
  suite "Perfect numbers":
    test "first 5 perfect numbers":
      check fivePerfectNumbers() == [6, 28, 496, 8128, 33550336]
