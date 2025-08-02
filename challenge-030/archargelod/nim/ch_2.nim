#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc sorted(a: array[3, int]): array[3, int] =
  result = a
  if result[1] < result[0]:
    swap(result[1], result[0])

  if result[2] < result[1]:
    swap(result[2], result[1])
    if result[1] < result[0]:
      swap(result[1], result[0])

proc possibleSeriesOf3(val: int): seq[array[3, int]] =
  for n1 in countUp(2, val, 2):
    var n = [n1, val - n1, 0]
    while n[1] > n[2]:
      inc n[2]
      dec n[1]
      let newSeries = n.sorted()
      if newSeries notin result:
        result.add newSeries

when isMainModule:
  import std/unittest

  const
    Expected = [
      [1, 2, 9],
      [2, 2, 8],
      [2, 3, 7],
      [2, 4, 6],
      [2, 5, 5],
      [1, 4, 7],
      [3, 4, 5],
      [4, 4, 4],
      [1, 5, 6],
      [3, 3, 6],
      [1, 3, 8],
      [1, 1, 10],
    ]

  suite "Sums of 3 numbers equal to 12":
    test "12 possible series":
      check possibleSeriesOf3(12) == Expected
