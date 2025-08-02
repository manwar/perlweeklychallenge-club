import std/unittest

from std/sequtils import countIt

# run tests with following command:
# nim c -r ch_1.nim

func max_positive_negative[T: SomeInteger](ints: openArray[T]): T =
  max(countIt(ints, it > 0), countIt(ints, it < 0))

suite "max positive negative":
  test "[-3, 1, 2, -1, 3, -2, 4]":
    check(max_positive_negative([-3, 1, 2, -1, 3, -2, 4]) == 4)

  test "[-1, -2, -3, 1]":
    check(max_positive_negative([-1, -2, -3, 1]) == 3)

  test "[1, 2]":
    check(max_positive_negative([1, 2]) == 2)
