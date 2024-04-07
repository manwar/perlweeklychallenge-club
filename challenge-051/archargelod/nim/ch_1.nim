#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[math, algorithm, bitops]

proc findAll3sums*(numbers: openarray[int], target: int): seq[seq[int]] =
  for i in 1..2^numbers.len:
    if i.countSetBits != 3: continue

    var tmpResult: seq[int]
    for j in 0..<numbers.len:
      if i.testBit(j):
        tmpResult.add numbers[j]

    if tmpResult.sum != target: continue

    tmpResult.sort()
    result.add tmpResult

when isMainModule:
  import std/unittest

  const
    Test = ([-25, -10, -7, -3, 2, 4, 8, 10], 0)
    Expected = [@[-10, 2, 8], @[-7, -3, 10]]

  suite "3 Sum":
    test "Example 1":
      check findAll3sums(Test[0], Test[1]) == Expected
