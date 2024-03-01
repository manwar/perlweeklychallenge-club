#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc countEvenDigitsNumbers(numbers: openarray[Natural]): int =
  for num in numbers:
    if num < 0: raise newException(ValueError, "Only positive values allowed")
    if len($num) mod 2 == 0:
      inc result

when isMainModule:
  import std/unittest

  const
    Test = [@[10.Natural, 1, 111, 24, 1000], @[111, 1, 11111], @[2, 8, 1024, 256]]
    Expected = [3, 0, 1]

  suite "Count Even Digits Number":
    test "Example 1":
      check countEvenDigitsNumbers(Test[0]) == Expected[0]
    test "Example 2":
      check countEvenDigitsNumbers(Test[1]) == Expected[1]
    test "Example 3":
      check countEvenDigitsNumbers(Test[2]) == Expected[2]
