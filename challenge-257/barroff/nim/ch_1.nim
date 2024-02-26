import std/[sugar, unittest]

from std/math import sqrt
from std/sequtils import filter, map, toSeq

# run tests with following command:
# nim c -r ch_1.nim

func smaller_than_current[T: SomeInteger](ints: openArray[T]): seq[int] =
  for i in ints:
    let
      j: T = i
    add(result, len(filter(ints, x => x < j)))

suite "smaller than current":
  test "[5, 2, 1, 6]":
    check(smaller_than_current([5, 2, 1, 6]) == @[2, 1, 0, 3])

  test "[1, 2, 0, 3]":
    check(smaller_than_current([1, 2, 0, 3]) == @[1, 2, 0, 3])

  test "[0, 1]":
    check(smaller_than_current([0, 1]) == @[0, 1])

  test "[9, 4, 9, 2]":
    check(smaller_than_current([9, 4, 9, 2]) == @[2, 1, 2, 0])
