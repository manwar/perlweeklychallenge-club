import std/unittest

from std/algorithm import sorted
from std/sequtils import filterIt, toSeq

# run tests with following command:
# nim r ch_1.nim

proc checkOrder(ints: openArray[int]): seq[int] =
  let
    sortedInts: seq[int] = sorted(ints)

  result = filterIt(toSeq(0..<len(ints)), ints[it] != sortedInts[it])

suite "check order":
  test "[5, 2, 4, 3, 1]":
    check(checkOrder([5, 2, 4, 3, 1]) == [0, 2, 3, 4])

  test "[1, 2, 1, 1, 3]":
    check(checkOrder([1, 2, 1, 1, 3]) == [1, 3])

  test "[3, 1, 3, 2, 3]":
    check(checkOrder([3, 1, 3, 2, 3]) == [0, 1, 3])
