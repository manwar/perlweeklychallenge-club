import std/[sugar, unittest]

from std/math import sum
from std/sequtils import map, toSeq

# run tests with following command:
# nim r ch_1.nim

proc maximumAverage(ints: openArray[int], n: int): float =
  var
    s: int = 0

  for i in 0..len(ints) - n:
    s = sum(ints[i..i+n-1])
    result = max(result, s / n)

suite "maximum average":
  test "[1, 12, -5, -6, 50, 3], 4":
    check(maximumAverage([1, 12, -5, -6, 50, 3], 4) == 12.75)

  test "[5], 1":
    check(maximumAverage([5], 1) == 5)
