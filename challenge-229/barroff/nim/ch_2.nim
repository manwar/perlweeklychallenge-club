import std/[setutils, unittest]

# run tests with following command:
# nim c -r ch_2.nim

proc two_out_of_three(array1, array2, array3: openArray[int8]): set[int8] =
  let
    s1 = toSet(array1)
    s2 = toSet(array2)
    s3 = toSet(array3)
  result = s1 * s2 + s1 * s3 + s2 * s3

suite "two out of three":
  test "(1, 1, 2, 4), (2, 4), (4)":
    let
      s1 = [1'i8, 1, 2, 4]
      s2 = [2'i8, 4]
      s3 = [4'i8]

    check(two_out_of_three(s1, s2, s3) == toSet([2'i8, 4]))

  test "(4, 1), (2, 4), (1, 2)":
    let
      s1 = [4'i8, 1]
      s2 = [2'i8, 4]
      s3 = [1'i8, 2]

    check(two_out_of_three(s1, s2, s3) == toSet([1'i8, 2, 4]))
