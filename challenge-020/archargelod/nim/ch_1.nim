#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc splitSameChars(s: string): seq[string] =
  result = newSeqOfCap[string](s.len)
  result.add $s[0]

  for c in s.toOpenArray(1, s.high):
    if c != result[^1][^1]:
      result.add $c
    else:
      result[^1] &= c

when isMainModule:
  import std/unittest

  const
    Test = "ABBCDEEF"
    Expected = ["A", "BB", "C", "D", "EE", "F"]

  suite "Same-character groups":
    test "Example 1":
      check Test.splitSameChars() == Expected
