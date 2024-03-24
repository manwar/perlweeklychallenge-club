#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

proc isGapful(n: int): bool =
  let last = n mod 10
  let first = int(n / (10 ^ int log10(float n)))
  n mod (first * 10 + last) == 0

proc firstGapfulNumbers(n: int): seq[int] =
  var number = 100
  while result.len < n:
    if number.isGapful():
      result.add number
    inc number

when isMainModule:
  import std/unittest

  const
    Test = 20
    Expected = [100, 105, 108, 110, 120, 121, 130, 132, 135, 140, 143, 150, 154,
                160, 165, 170, 176, 180, 187, 190]

  suite "Gapful Number":
    test "first 20":
      check firstGapfulNumbers(Test) == Expected
