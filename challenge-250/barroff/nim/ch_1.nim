import std/unittest

# run tests with following command:
# nim c -r ch_1.nim

proc smallest_index[T: SomeInteger](ints: openArray[T]): int =
  for i, elem in ints:
    if elem == i mod 10:
      return i
  result = -1

suite "smallest index":
  test "(0, 1, 2)":
    let
      l1 = [0, 1, 2]

    check(smallest_index(l1) == 0)

  test "(4, 3, 2, 1)":
    let
      l1 = [4, 3, 2, 1]

    check(smallest_index(l1) == 2)

  test "(1, 2, 3, 4, 5, 6, 7, 8, 9, 0)":
    let
      l1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]

    check(smallest_index(l1) == -1)
