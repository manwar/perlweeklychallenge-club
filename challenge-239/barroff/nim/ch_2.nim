import std/[sequtils, setutils, sugar, unittest]

# run tests with following command:
# nim c -r ch_2.nim

proc consistent_strings(allowed: string, arr1: openArray[string]): int =
  let
    allowed_chars = toSet(allowed)
  result = countIt(mapIt(arr1, toSet(it)), it <= allowed_chars)

suite "consistent strings":
  test "\"ab\", [\"ad\", \"bd\", \"aaab\", \"baa\", \"badab\"]":
    let
      allowed = "ab"
      arr1 = ["ad", "bd", "aaab", "baa", "badab"]

    check(consistent_strings(allowed, arr1) == 2)

  test "\"abc\", [\"a\", \"b\", \"c\", \"ab\", \"ac\", \"bc\", \"abc\"]":
    let
      allowed = "abc"
      arr1 = ["a", "b", "c", "ab", "ac", "bc", "abc"]

    check(consistent_strings(allowed, arr1) == 7)

  test "\"cad\", [\"cc\", \"acd\", \"b\", \"ba\", \"bac\", \"bad\", \"ac\", \"d\"]":
    let
      allowed = "cad"
      arr1 = ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"]

    check(consistent_strings(allowed, arr1) == 4)
