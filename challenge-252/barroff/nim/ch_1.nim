import std/unittest

# run tests with following command:
# nim c -r ch_1.nim

proc special_numbers(n: openArray[int]): int =
  for i in 1 .. len(n):
    if len(n) mod i == 0:
      result += n[i - 1] * n[i - 1]

suite "special numbers":
  test "[1, 2, 3, 4]":
    check(special_numbers([1, 2, 3, 4]) == 21)

  test "[2, 7, 1, 19, 18, 3]":
    check(special_numbers([2, 7, 1, 19, 18, 3]) == 63)
