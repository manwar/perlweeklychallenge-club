import std/[algorithm, sequtils, unittest]

# run tests with following command:
# nim c -r ch_2.nim

proc greatness(list1, list2: openArray[int]): int =
  result = len(zip(list1, list2).filterIt(it[0] < it[1]))

proc maximise_greatness(a: openArray[int]): int =
  var
    sa: seq[int] = sorted(a)
  result = greatness(a, sa)
  while nextPermutation(sa):
    result = max(result, greatness(a, sa))

suite "maximise_greatness":
  test "(1, 3, 5, 2, 1, 3, 1)":
    let
      ints = [1, 3, 5, 2, 1, 3, 1]
      mg = maximise_greatness(ints)

    check(mg == 4)

  test "(1, 2, 3, 4)":
    let
      ints = [1, 2, 3, 4]
      mg = maximise_greatness(ints)

    check(mg == 3)
