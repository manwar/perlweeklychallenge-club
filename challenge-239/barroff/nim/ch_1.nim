import std/[strutils, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc same_string(arr1, arr2: openArray[string]): bool =
  result = join(arr1, "") == join(arr2, "")

suite "same string":
  test "[\"ab\", \"c\"] [\"a\", \"bc\"]":
    let
      arr1 = ["ab", "c"]
      arr2 = ["a", "bc"]
    check(same_string(arr1, arr2) == true)

  test "[\"ab\", \"c\"] [\"ac\", \"b\"]":
    let
      arr1 = ["ab", "c"]
      arr2 = ["ac", "b"]
    check(same_string(arr1, arr2) == false)

  test "[\"ab\", \"cd\", \"e\"] [\"abcde\"]":
    let
      arr1 = ["ab", "cd", "e"]
      arr2 = ["abcde"]
    check(same_string(arr1, arr2) == true)
