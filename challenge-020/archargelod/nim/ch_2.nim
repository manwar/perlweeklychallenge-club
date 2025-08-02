#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc aliquotSum[T: SomeInteger](n: T): T =
  for d in T(1) .. T(n div 2):
    if n mod d == 0:
      result += d

proc smallestAmicablePair(): (int, int) =
  var invalid: set[int16] # could be useful for later pairs

  for first in 1'i16 .. high(int16):
    if first in invalid: continue

    let second = aliquotSum(first)
    if second != first and aliquotSum(second) == first:
      return (first.int, second.int)

    invalid.incl first
    invalid.incl second

when isMainModule:
  import std/unittest

  const Expected = (220, 284)

  suite "Smallest Amicable Number pair":
    test "first pair is 220 and 284":
      check smallestAmicablePair() == Expected
