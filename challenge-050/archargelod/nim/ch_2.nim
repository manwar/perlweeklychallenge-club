#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[algorithm, options]

proc findNoble*(numbers: openArray[int]): Option[int] =
  let numbers = numbers.sorted()
  for i in 1..numbers.len:
    let num = numbers[^i]
    if num == i - 1:
      return some(num)
  none(int)


when isMainModule:
  import std/unittest

  const
    Test = [2, 1, 6, 3]
    Expected = 2

  suite "Noble Integer":
    test "Example 1":
      check findNoble(Test).get == Expected
