#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/bitops

proc highestOneBit(n: int): int =
  if n == 0: return 0
  1 shl (sizeof(n) * 8 - countLeadingZeroBits(n) - 1)

proc josephusSurvivor(n: int): int =
  not(highestOneBit(n*2)) and ((n shl 1) or 1)
when isMainModule:
  import std/unittest

  const
    Test = 50
    Expected = 37

  suite "Survivor":
    test "50 people, k = 2":
      check josephusSurvivor(Test) == Expected
