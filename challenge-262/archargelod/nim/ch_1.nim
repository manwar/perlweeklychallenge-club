#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

type
  NumberSign = enum
    Positive
    Negative
    Zero

proc maxSign(numbers: openarray[int]): (int, NumberSign) =
  var
    positiveCnt, negativeCnt: int

  for num in numbers:
    if num > 0:
      inc positiveCnt
    elif num < 0:
      inc negativeCnt

  if positiveCnt > negativeCnt:
    (positiveCnt, Positive)
  else:
    (negativeCnt, Negative)


when isMainModule:
  import std/unittest

  const
    Test = [
      @[-3, 1, 2, -1, 3, -2, 4],
      @[-1, -2, -3, 1],
      @[1,2],
    ]
    Expected = [
      (4, Positive),
      (3, Negative),
      (2, Positive),
    ]

  suite "Max Positive Negative":
    test "Example 1":
      check maxSign(Test[0]) == Expected[0]
    test "Example 2":
      check maxSign(Test[1]) == Expected[1]
    test "Example 3":
      check maxSign(Test[2]) == Expected[2]
