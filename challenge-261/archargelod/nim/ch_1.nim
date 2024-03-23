#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/sequtils

proc diffElementDigitSums(numbers: openArray[int]): int =
  for num in numbers:
    if num < 10: continue
    let digitSum = ($num).mapIt(it.ord - '0'.ord).foldl(a+b)
    result += num - digitSum


when isMainModule:
  import std/unittest

  const
    Test = [
      @[1,2,3,45],
      @[1,12,3],
      @[1,2,3,4],
      @[236, 416, 336, 350],
    ]
    Expected = [36, 9, 0, 1296]

  suite "Element Digit Sum":
    test "Example 1":
      check diffElementDigitSums(Test[0]) == Expected[0]
    test "Example 2":
      check diffElementDigitSums(Test[1]) == Expected[1]
    test "Example 3":
      check diffElementDigitSums(Test[2]) == Expected[2]
    test "Example 4":
      check diffElementDigitSums(Test[3]) == Expected[3]
