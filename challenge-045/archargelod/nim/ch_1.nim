#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, sequtils]

proc squareCoded(input: string): string =
  const Columns = 8
  let input = input.filterIt(it in Letters).toLower()

  for x in 0..<Columns:
    var y = 0
    while y * Columns + x < input.len:
      result.add input[y * Columns + x]
      inc y
    result.add ' '

  result.setLen(result.len - 1)

when isMainModule:
  import std/unittest

  const
    Test = "The quick brown fox jumps over the lazy dog"
    Expected = "tbjrd hruto eomhg qwpe unsl ifoa covz kxey"

  suite "Square secret code":
    test "":
      check squareCoded(Test) == Expected
