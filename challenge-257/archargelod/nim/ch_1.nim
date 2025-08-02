#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sugar, algorithm]

proc mapToSmallerValuesCount*(numbers: sink seq[int]): seq[int] =
  ## ~10x faster than naive method
  var indexed = collect(
    for i, n in numbers:
      (i, n)
  )
  indexed.sort((t1, t2) => cmp(t1[1], t2[1]))

  result = numbers

  var prev: tuple[val, index: int]
  for curIndex, (origIndex, curVal) in indexed:
    result[origIndex] =
      if curVal == prev.val:
        prev.index
      else:
        prev = (curVal, curIndex)
        curIndex

when isMainModule:
  import std/unittest

  const
    Test = [@[5, 2, 1, 6], @[1, 2, 0, 3], @[0, 1], @[9, 4, 9, 2]]
    Expected = [@[2, 1, 0, 3], @[1, 2, 0, 3], @[0, 1], @[2, 1, 2, 0]]

  suite "Smaller than Current":
    test "Example 1":
      check mapToSmallerValuesCount(Test[0]) == Expected[0]
    test "Example 2":
      check mapToSmallerValuesCount(Test[1]) == Expected[1]
    test "Example 3":
      check mapToSmallerValuesCount(Test[2]) == Expected[2]
    test "Example 4":
      check mapToSmallerValuesCount(Test[3]) == Expected[3]
