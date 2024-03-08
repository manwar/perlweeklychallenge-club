#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

when isMainModule:
  import std/unittest

  const
    Test = "Write a program that demonstrates using hash slices and/or array slices."
    Expected = "Here's a program that demonstrates using the array slices."

  suite "Hash and/or array slices":
    test "Example 1":
      var res = Test
      res[0..4] = "Here's"
      res[41..58] = "the"
      check res == Expected
    test "Example 2":
      let res = "Here's" & Test[5..39] & "the" & Test[58..^1]
      check res == Expected


