import std/unittest

from std/sequtils import minmax, repeat

# run tests with following command:
# nim c -r ch_1.nim

proc consequtive_sequence[T: SomeInteger](ints: openArray[T]): int =
  let
    (mn, mx) = minmax(ints)
  var
    currentSeq = 0
    longestSeq = 1
    spots: seq[bool] = repeat(false, mx + 1 - mn)

  for x in ints:
    spots[x - mn] = true
  for x in spots:
    if x:
      inc(currentSeq)
    elif currentSeq != 0:
      longestSeq = max(longestSeq, currentSeq)
      currentSeq = 0

  longestSeq = max(longestSeq, currentSeq)
  return if longestSeq == 1: -1 else: longestSeq


suite "consecutive sequence":
  test "[10, 4, 20, 1, 3, 2]":
    check(consequtive_sequence([10, 4, 20, 1, 3, 2]) == 4)

  test "[0, 6, 1, 8, 5, 2, 4, 3, 0, 7]":
    check(consequtive_sequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]) == 9)

  test "[10, 30 , 20]":
    check(consequtive_sequence([10, 30, 20]) == -1)
