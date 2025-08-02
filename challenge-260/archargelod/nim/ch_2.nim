#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[algorithm]

proc dictionaryRank(word: string): int =
  var letters = word.sorted()

  result = 1
  while letters != word:
    doAssert nextPermutation(letters)
    inc result

when isMainModule:
  import std/unittest

  const
    Test = ["CAT", "GOOGLE", "SECRET"]
    Expected = [3, 88, 255]

  suite "Dictionary Rank":
    test "Example 1":
      check dictionaryRank(Test[0]) == Expected[0]
    test "Example 2":
      check dictionaryRank(Test[1]) == Expected[1]
    test "Example 3":
      check dictionaryRank(Test[2]) == Expected[2]
