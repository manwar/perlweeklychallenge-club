import std/[sugar, unittest]

from std/algorithm import nextPermutation
from std/sequtils import toSeq

# run tests with following command:
# nim r ch_1.nim

func isBeautiful(n, i: int): bool =
  n mod i == 0 or i mod n == 0

func checkArrangement(arrangement: openArray[int]): bool =
  for k, v in arrangement:
    if not isBeautiful(k + 1, v):
      return false
  return true

func beautifulArrangement(integer: int): int =
  var
    perm: seq[int] = toSeq(1..integer)
  inc(result)
  while nextPermutation(perm):
    if checkArrangement(perm):
      inc(result)

suite "beautiful arrangement":
  test "2":
    check(beautifulArrangement(2) == 2)

  test "1":
    check(beautifulArrangement(1) == 1)

  test "10":
    check(beautifulArrangement(10) == 700)

  test "11":
    check(beautifulArrangement(11) == 750)
