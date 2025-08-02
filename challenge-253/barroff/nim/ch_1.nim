import std/unittest

from std/strutils import split

# run tests with following command:
# nim c -r ch_1.nim

proc split_strings(separator: char, words: openArray[string]): seq[string] =
  for word in words:
    for s in split(word, separator):
      if len(s) > 0:
        result.add(s)


suite "split strings":
  test """("one.two.three","four.five","six")""":
    let
      words = ["one.two.three", "four.five", "six"]
      separator = '.'

    check(split_strings(separator, words) == @["one", "two", "three", "four",
        "five", "six"])

  test """("$perl$$", "$$raku$")""":
    let
      words = ["$perl$$", "$$raku$"]
      separator = '$'

    check(split_strings(separator, words) == @["perl", "raku"])
