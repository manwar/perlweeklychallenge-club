#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import sequtils

proc nthOrderForwardDifference(numbers: openarray[int], order = 1): seq[int] =
  result = numbers.toSeq
  for i in 1..order:
    for j, num in result.toOpenArray(0, result.high - 1):
      result[j] = result[j+1] - num
    result.setLen(result.len - 1)

when isMainModule:
  import std/unittest

  const
    Test = [5, 9, 2, 8, 1, 6]
    Expected = [
      @[4, -7, 6, -7, 5],
      @[-11, 13, -13, 12],
    ]

  suite "nth order forward difference series":
    test "first order":
      check Test.nthOrderForwardDifference(1) == Expected[0]
    test "second order":
      check Test.nthOrderForwardDifference(2) == Expected[1]
