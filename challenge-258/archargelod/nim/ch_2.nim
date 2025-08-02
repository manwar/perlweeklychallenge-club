#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/strutils

proc indexSetBitsNumberSum(numbers: openarray[int], setBits: int): int =
  for ind, num in numbers:
    if ind.toBin(64).count('1') == setBits:
      result += num

when isMainModule:
  import std/unittest

  const
    Test = [(@[2, 5, 9, 11, 3], 1), (@[2, 5, 9, 11, 3], 2), (@[2, 5, 9, 11, 3], 0)]
    Expected = [17, 11, 2]

  suite "Sum of Values":
    test "Example 1":
      check indexSetBitsNumberSum(Test[0][0], Test[0][1]) == Expected[0]
    test "Example 2":
      check indexSetBitsNumberSum(Test[1][0], Test[1][1]) == Expected[1]
    test "Example 3":
      check indexSetBitsNumberSum(Test[2][0], Test[2][1]) == Expected[2]
