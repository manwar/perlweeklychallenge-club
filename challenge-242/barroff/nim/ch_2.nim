import std/[algorithm, sequtils, sugar, unittest]

# run tests with following command:
# nim c -r ch_2.nim

proc flip_matrix(matrix: seq[seq[int]]): seq[seq[int]] =
  result = map(matrix, proc(x: seq[int]): seq[int] = mapIt(reversed(x), if it == 0: 1 else: 0))

suite "flip matrix":
  test "@[@[1, 1, 0], @[1, 0, 1], @[0, 0, 0]]":
    let
      matrix = @[@[1, 1, 0], @[1, 0, 1], @[0, 0, 0]]
      expected = @[@[1, 0, 0], @[0, 1, 0], @[1, 1, 1]]
      res = flip_matrix(matrix)

    check(expected == res)

  test "@[@[1, 1, 0, 0], @[1, 0, 0, 1], @[0, 1, 1, 1], @[1, 0, 1, 0]]":
    let
      matrix = @[@[1, 1, 0, 0], @[1, 0, 0, 1], @[0, 1, 1, 1], @[1, 0, 1, 0]]
      expected = @[@[1, 1, 0, 0], @[0, 1, 1, 0], @[0, 0, 0, 1], @[1, 0, 1, 0]]
      res = flip_matrix(matrix)

    check(expected == res)
