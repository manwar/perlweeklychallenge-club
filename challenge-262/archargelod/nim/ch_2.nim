#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc equalIndexesProductDivisibleByKCount(numbers: openarray[int], k: int): int =
  doAssert numbers.len > 1
  for i, val1 in numbers:
    for j, val2 in numbers[i+1..^1]:
      let j = i + 1 + j
      if (val1 == val2) and (i*j mod k == 0):
        inc result

when isMainModule:
  import std/unittest

  const
    Test = [
      (@[3,1,2,2,2,1,3], 2),
      (@[1,2,3], 1),
    ]
    Expected = [4, 0]

  suite "Count Equal Divisible":
    test "Example 1":
      check equalIndexesProductDivisibleByKCount(Test[0][0], Test[0][1]) == Expected[0]
    test "Example 2":
      check equalIndexesProductDivisibleByKCount(Test[1][0], Test[1][1]) == Expected[1]
