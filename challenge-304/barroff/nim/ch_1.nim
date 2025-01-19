import std/unittest

from std/math import sum
from std/sequtils import count

# run tests with following command:
# nim r ch_1.nim

type
  Bin = range[0..1]

proc arrangeBinary(digits: openArray[Bin], n: int): bool =
  let
    countOfZeros: int = count(digits, 0) - n
    countOfOnes: int = len(digits) - countOfZeros

  result = countOfZeros + 1 >= countOfOnes

suite "arrange binary":
  test "[1, 0, 0, 0, 1], 1":
    check(arrangeBinary([Bin(1), 0, 0, 0, 1], 1))

  test "[1, 0, 0, 0, 1], 2":
    check(not(arrangeBinary([Bin(1), 0, 0, 0, 1], 2)))
