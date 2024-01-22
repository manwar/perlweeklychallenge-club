import std/unittest

from std/algorithm import sort
from std/sequtils import map

# run tests with following command:
# nim c -r ch_2.nim

proc unique_sum_zero(n: Natural): seq[int] =
  result = newSeqOfCap[int](n)
  for i in 1..n div 2:
    add(result, [i, -i])
  if n mod 2 == 1:
    add(result, 0)
  sort(result)

suite "unique sum zero":
  test "5":
    check(unique_sum_zero(5) == @[-2, -1, 0, 1, 2])

  test "3":
    check(unique_sum_zero(3) == @[-1, 0, 1])

  test "1":
    check(unique_sum_zero(1) == @[0])

  test "0":
    check(unique_sum_zero(0) == newSeqOfCap[int](0))
