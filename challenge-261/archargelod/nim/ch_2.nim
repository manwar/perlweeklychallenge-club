#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc searchThenDoubleRepeat(numbers: openarray[int], value: int): int =
  result = value
  while true:
    block lookingForValue:
      for num in numbers:
        if num == result:
          result *= 2
          break lookingForValue
      return

when isMainModule:
  import std/unittest

  const
    Test: array[3, tuple[arr: seq[int], value: int]] = [
      (@[5,3,6,1,12], 3),
      (@[1,2,4,3], 1),
      (@[5,6,7], 2),
    ]
    Expected = [24, 8, 2]

  suite "Multiply by Two":
    test "Example 1":
      check Test[0].arr.searchThenDoubleRepeat(Test[0].value) == Expected[0]
    test "Example 2":
      check Test[1].arr.searchThenDoubleRepeat(Test[1].value) == Expected[1]
    test "Example 3":
      check Test[2].arr.searchThenDoubleRepeat(Test[2].value) == Expected[2]
