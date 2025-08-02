#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

proc vanEckNth*(nth: Natural): int =
  ## returns nth term of Van Eck's sequence
  ## starting from 0-th term: [a(0) = 0]
  var lastPos: Table[int, int]

  var prev = 0
  for n in 1 .. nth:
    if prev notin lastPos:
      lastPos[prev] = n - 1
      prev = 0
      continue

    let m = lastPos[prev]
    lastPos[prev] = n - 1
    prev = n - 1 - m

  result = prev

proc vanEckSequence*(count: Positive): seq[int] =
  ## blazingly fast!
  ## sub 1ms with 20_000 terms
  result = newSeq[int](count)
  var lastPos: Table[int, int]

  for n in 1 ..< count:
    let prev = result[n - 1]
    if prev notin lastPos:
      lastPos[prev] = n - 1
      continue

    let m = lastPos[prev]
    lastPos[prev] = n - 1
    result[n] = n - 1 - m

when isMainModule:
  import std/unittest

  const
    Count = 97
    Expected = [
      0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5, 3, 0, 3, 2, 9, 0, 4, 9,
      3, 6, 14, 0, 6, 3, 5, 15, 0, 5, 3, 5, 2, 17, 0, 6, 11, 0, 3, 8, 0, 3, 3, 1, 42, 0,
      5, 15, 20, 0, 4, 32, 0, 3, 11, 18, 0, 4, 7, 0, 3, 7, 3, 2, 31, 0, 6, 31, 3, 6, 3,
      2, 8, 33, 0, 9, 56, 0, 3, 8, 7, 19, 0, 5, 37, 0, 3, 8, 8, 1
    ]

  suite "Van Eck's sequence":
    test "first 97 terms":
      check vanEckSequence(Count) == Expected
