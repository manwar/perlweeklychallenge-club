import std/[sugar, unittest]

from std/sequtils import filter, map
from std/strutils import removePrefix, startsWith

# run tests with following command:
# nim c -r ch_1.nim

proc word_break(str: string, words: openArray[string]): bool =
  if str in words:
    return true

  let
    starters = filter(words, x => startsWith(str, x))

  if len(starters) != 0:
    var
      remainingString: string
    for s in starters:
      remainingString = str
      removePrefix(remainingString, s)
      if word_break(remainingString, words):
        return true

  return false

suite "word break":
  test "weeklychallenge":
    check(word_break("weeklychallenge", ["challenge", "weekly"]))

  test "perlrakuperl":
    check(word_break("perlrakuperl", ["raku", "perl"]))

  test "sonsanddaughters":
    check(word_break("sonsanddaughters", ["sons", "sand", "daughters"]) == false)
