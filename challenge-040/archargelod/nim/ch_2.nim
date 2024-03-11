#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/algorithm

proc sortSublist[T](arr: var openarray[T], indices: varargs[int]) =
  var tmp: seq[int]
  for i in indices:
    tmp.add arr[i]

  tmp.sort()

  for i, val in tmp:
    arr[indices[i]] = val


when isMainModule:
  import std/unittest

  const
    Test = ([10, 4, 1, 8, 12, 3], [0, 2, 5])
    Expected = [1, 4, 3, 8, 12, 10]

  suite "Sort SubList":
    test "Example 1":
      var a = Test[0]
      a.sortSublist(Test[1])
      check a == Expected
