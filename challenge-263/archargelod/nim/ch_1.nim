#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
# task: Write a script to return the list of indices in the sorted array where the element is same as the given target element.
# solution: no sorting, count elements that are less than target, that's our starting index, then for each copy add ind+1 to result

proc sortedIndexes*(arr: openarray[int], target: int): seq[int] =
  var firstInd = 0
  var count = 0
  for elem in arr:
    if elem < target:
      inc firstInd
    elif elem == target:
      inc count

  for i in 1..count:
    result.add firstInd
    inc firstInd

when isMainModule:
  import std/unittest

  const
    Test = [
      (@[1, 5, 3, 2, 4, 2], 2),
      (@[1, 2, 4, 3, 5], 6),
      (@[5, 3, 2, 4, 2, 1], 4),
    ]
    Expected = [
      @[1, 2],
      @[],
      @[4],
    ]

  suite "Target Index":
    test "Example 1":
      check sortedIndexes(Test[0][0], Test[0][1]) == Expected[0]
    test "Example 2":
      check sortedIndexes(Test[1][0], Test[1][1]) == Expected[1]
    test "Example 3":
      check sortedIndexes(Test[2][0], Test[2][1]) == Expected[2]
