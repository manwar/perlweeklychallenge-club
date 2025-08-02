#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[parseutils, strformat, strutils]

proc commonPath(paths: openarray[string], sep = '/'): string =
  var stack: seq[string]
  for pathInd, path in paths:
    if path[0] != sep:
      raise newException(ValueError, &"paths should start with '{sep}'")

    var depth = 0
    var index = 1
    while index <= path.high:
      let dirLength = path.skipUntil({sep}, index)

      if dirLength < 1: # treat multiple separators as one (how it works on linux)
        inc index
        continue

      let dirName = path[index ..< index + dirLength]

      if pathInd == 0:
        stack.add dirName
      elif depth > stack.high or stack[depth] != dirName:
        stack.setLen(depth)
        break
      elif depth == stack.high:
        break

      inc depth
      index += dirLength + 1

  sep & stack.join($sep)

when isMainModule:
  import std/unittest

  const
    TestPaths = ["/a/b/c/d", "/a/b/cd", "/a/b/cc", "/a/b/c/d/e"]
    Expected = "/a/b"

  suite "Common directory":
    test "Example 1":
      check commonPath(TestPaths) == Expected
