#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/algorithm

proc merge*(intervals: openarray[HSlice[int, int]]): seq[HSlice[int, int]] =
  var intervals = intervals.sortedByIt(it.a)

  result.add intervals[0]
  for interval in intervals.toOpenArray(1, intervals.high):
    if interval.a <= result[^1].b:
      result[^1].b = interval.b
    else:
      result.add interval

when isMainModule:
  import std/unittest

  const
    Test = [2..7, 3..9, 10..12, 15..19, 18..22]
    Expected = [2..9, 10..12, 15..22]

  suite "Merge Intervals":
    test "Example 1":
      check merge(Test) == Expected
