#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/strutils

proc center(lines: varargs[string]): seq[string] =
  let maxOffset = block:
    var maxLen = 0
    for line in lines:
      if line.len > maxLen:
        maxLen = line.len
    maxLen div 2

  for line in lines:
    result.add ' '.repeat(maxOffset - line.len div 2) & line

when isMainModule:
  import std/unittest

  const Example = ["This", "is", "a test of the", "center function"]
  const Expected = ["     This", "      is", " a test of the", "center function"]

  suite "Centering strings":
    test "Example 1":
      check center(Example) == Expected
