import std/[algorithm, sequtils, strutils, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc is_lexicographic(s: string): bool =
  var
    splitted = toSeq(s)
  sort(splitted, system.cmp[char])
  let
    sorted_s = join(splitted)
  reverse(splitted)
  let
    reverse_sorted_s = join(splitted)
  result = s == sorted_s or s == reverse_sorted_s

proc lexicographic_order(words: openArray[string]): int =
  len(filter(words, proc(s: string): bool = not(is_lexicographic(s))))

suite "lexicographic order":
  test "\"abc\", \"bce\", \"cae\"":
    var
      s = @["abc", "bce", "cae"]

    check(lexicographic_order(s) == 1)

  test "\"yxz\", \"cba\", \"mon\"":
    var
      s = @["yxz", "cba", "mon"]
    check(lexicographic_order(s) == 2)
