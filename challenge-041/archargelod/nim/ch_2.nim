#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc leonardoNumbers(n: int): seq[int] =
  result = newSeq[int](n)
  result[0..1] = [1, 1]
  for i in 2..<n:
    result[i] = result[i-2] + result[i-1] + 1

when isMainModule:
  import std/unittest

  const
    Expected = [
      1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753, 1219, 1973, 3193,
      5167, 8361, 13529
    ]

  suite "Leonardo numbers":
    test "first 20":
      check leonardoNumbers(20) == Expected

