import std/[sugar, unittest]

from std/algorithm import nextPermutation
from std/sequtils import toSeq

# run tests with following command:
# nim r ch_1.nim

func stepByStep(ints: openArray[int]): int =
  var
    xmin: int = 0
  for i in ints:
    result += i
    if result < xmin:
      xmin = result

  if xmin == 0:
    result = 1
  else:
    result = 1 - xmin

suite "step by step":
  test "[-3, 2, -3, 4, 2]":
    check(stepByStep([-3, 2, -3, 4, 2]) == 5)

  test "[1, 2]":
    check(stepByStep([1, 2]) == 1)

  test "[1, -2, -3]":
    check(stepByStep([1, -2, -3]) == 5)
