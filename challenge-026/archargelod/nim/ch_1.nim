#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils]

proc countLetters(input, alphabet: string): int =
  let uniq = block:
    var tmp: set[char]
    for c in alphabet:
      if c notin Letters: continue
      tmp.incl c
    tmp

  for c in input:
    if c in uniq:
      inc result

when isMainModule:
  import std/unittest

  const
    Test = "chancellor"
    Alphabet = "chocolate"
    Expected = 8

  suite "Stones and jewels alphabets":
    test "Example 1":
      check Test.countLetters(Alphabet) == Expected
