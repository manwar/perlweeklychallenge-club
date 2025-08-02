#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils]

proc barGraph(valuePairs: openarray[(string, int)], magnitude = 1): string =
  const minOffset = 8
  for (label, value) in valuePairs:
    let offset = ' '.repeat(max(0, minOffset - label.len))
    result &= label & offset & " | " & '#'.repeat(value * magnitude) & '\n'

when isMainModule:
  import std/unittest

  const
    Test = {"apple": 3, "banana": 1, "cherry": 2}
    Expected = """
apple    | ############
banana   | ####
cherry   | ########
"""

  suite "ASCII bar chart":
    test "Example 1":
      check barGraph(Test, 4) == Expected
