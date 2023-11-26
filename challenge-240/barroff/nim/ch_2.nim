import std/[sequtils, sugar, unittest]

# run tests with following command:
# nim c -r ch_2.nim

proc build_array(ints: openArray[int]): seq[int] =
  result = mapIt(0..high(ints), if ints[it] >= len(ints): -1 else: ints[ints[it]])

suite "build array":
  test "(0, 2, 1, 5, 3, 4)":
    let
      ints = [0, 2, 1, 5, 3, 4]
      expected = [0, 1, 2, 4, 5, 3]
      res = build_array(ints)

    check(expected == res)

  test "(5, 0, 1, 2, 3, 4)":
    let
      ints = [5, 0, 1, 2, 3, 4]
      expected = [4, 5, 0, 1, 2, 3]
      res = build_array(ints)

    check(expected == res)
