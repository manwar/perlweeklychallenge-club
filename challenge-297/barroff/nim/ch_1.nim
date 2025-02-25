import std/unittest

from std/math import sum

# run tests with following command:
# nim c -r ch_1.nim

type
  bin = range[0..1]

proc contiguous_array(binary: openArray[int]): int =
  var
    s: int = sum(binary)
    j: int
  s = min(s, len(binary) - s)
  for i in countdown(s, 1):
    j = 2 * i - 1
    for k in low(binary)..high(binary) - j:
      if sum(binary[k..k+j]) == i:
        return 2 * i
  return 0

suite "contiguous array":
  test "[1, 0]":
    check(contiguous_array([1, 0]) == 2)

  test "[0, 1, 0]":
    check(contiguous_array([0, 1, 0]) == 2)

  test "[0, 0, 0, 0, 0]":
    check(contiguous_array([0, 0, 0, 0, 0]) == 0)

  test "[0, 1, 0, 0, 1, 0]":
    check(contiguous_array([0, 1, 0, 0, 1, 0]) == 4)
