#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc showMultipleSeqContent[T](arrays: openarray[seq[T]]): string =
  for i in arrays[0].low .. arrays[0].high:
    result &= arrays[0][i]
    for arr in arrays[1..^1]:
      result &= ' '
      result &= arr[i]
    result &= '\n'

when isMainModule:
  import std/unittest

  const
    Test = [
      @"ILOVEYOU",
      @"24032019",
      @"!?f$%^&*",
    ]
    Expected = """
I 2 !
L 4 ?
O 0 f
V 3 $
E 2 %
Y 0 ^
O 1 &
U 9 *
"""

  suite "Show multiple arrays content":
    test "Example 1":
      check Test.showMultipleSeqContent() == Expected
