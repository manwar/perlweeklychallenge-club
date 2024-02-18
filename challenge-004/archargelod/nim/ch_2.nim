#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

proc canBeMadeOf(word: string, letters: openarray[char]): bool =
  var dict = letters.toCountTable
  for c in word:
    if not dict.hasKey(c) or dict[c] <= 0:
      return false
    else:
      dict[c] = dict[c] - 1
  result = true

when isMainModule:
  import std/unittest

  const
    AvailableLetters = @"acdefhikllmnopqrstuvwxyz" # extra l; no [b, g, j]
    ValidWords = ["world", "python", "nim", "lua"]
    InvalidWords = ["java", "ruby", "javascript", "go", "bg"]
    WordWithMultipleSameLetters = "hello"
    WordWithExtraLetters = "helllo"
    SingleCharWord = "a"
    SingleCharNotInLetters = "g"
    EmptyWord = ""

  suite "valid words":
    test "should pass for valid words":
      for word in ValidWords:
        check word.canBeMadeOf AvailableLetters

    test "should pass for valid words with multiple of same letters":
      check WordWithMultipleSameLetters.canBeMadeOf AvailableLetters

    test "should pass for single character words":
      check SingleCharWord.canBeMadeOf AvailableLetters

    test "should pass for empty words":
      check EmptyWord.canBeMadeOf AvailableLetters

  suite "invalid words":
    test "should fail for invalid words":
      for word in InvalidWords:
        check not word.canBeMadeOf AvailableLetters

    test "should fail for valid words with extra letters":
      check not WordWithExtraLetters.canBeMadeOf AvailableLetters

    test "should fail for single character words not in letters":
      check not SingleCharNotInLetters.canBeMadeOf AvailableLetters

