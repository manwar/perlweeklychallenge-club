#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[sequtils]

type Matrix = seq[seq[int]]

proc identityMatrix*(size: Positive): Matrix =
  result = newSeqWith[int](size, newSeq[int](size))
  for i in 0 ..< size:
    result[i][i] = 1

when isMainModule:
  import std/unittest

  suite "Identity matrix of given size":
    test "2x2 matrix":
      check identityMatrix(2) == [@[1, 0], @[0, 1]]
    test "6x6 matrix":
      check identityMatrix(6) == [
        @[1, 0, 0, 0, 0, 0],
        @[0, 1, 0, 0, 0, 0],
        @[0, 0, 1, 0, 0, 0],
        @[0, 0, 0, 1, 0, 0],
        @[0, 0, 0, 0, 1, 0],
        @[0, 0, 0, 0, 0, 1]
      ]
