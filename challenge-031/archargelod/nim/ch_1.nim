#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc isDivisionByZero(num, denom: int): bool =
  num / denom == Inf

when isMainModule:
  import std/unittest

  const
    Test = [(15, 0), (15, 5)]
    Expected = [true, false]

  suite "Division by zero":
    test "Example 1":
      check isDivisionByZero(Test[0][0], Test[0][1]) == Expected[0]
    test "Example 2":
      check isDivisionByZero(Test[1][0], Test[1][1]) == Expected[1]
