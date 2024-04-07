#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[bitops, math]

proc smallestMultipleFrom1sAnd0s*(n: Positive): int =
  for i in 1..int.high:
    result = 0
    for j in 0..63:
      if i.testBit(j):
        result += 10^j

    if result mod n == 0: return

when isMainModule:
  import std/unittest

  const
    Test = 55
    Expected = 110

  suite "Smallest Multiple":
    test "Example 1":
      check smallestMultipleFrom1sAnd0s(Test) == Expected
