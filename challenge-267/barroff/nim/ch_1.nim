import std/unittest

from std/sequtils import countIt

# run tests with following command:
# nim c -r ch_1.nim

func product_sign[T: SomeInteger](ints: openArray[T]): int =
  if 0 in ints:
    return 0
  let
    negativeCount = countIt(ints, it < 0)
  if negativeCount mod 2 == 0:
    return 1
  return -1

suite "product sign":
  test "[-1, -2, -3, -4, 3, 2, 1]":
    check(product_sign([-1, -2, -3, -4, 3, 2, 1]) == 1)

  test "[1, 2, 0, -2, -1]":
    check(product_sign([1, 2, 0, -2, -1]) == 0)

  test "[-1, -1, 1, -1, 2]":
    check(product_sign([-1, -1, 1, -1, 2]) == -1)
