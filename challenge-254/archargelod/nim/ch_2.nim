#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, sugar]

const Vowels = {'a','e','i','o','u'}

proc reversedVowels*(s: string): string =
  let vowels = collect:
    for i in countDown(s.high, 0):
      let c = s[i].toLowerAscii
      if c in Vowels: c

  result = s

  var ind = 0
  for c in result.mItems:
    if c.toLowerAscii in Vowels:
      c = if c.isUpperAscii: vowels[ind].toUpperAscii else: vowels[ind]
      inc ind

when isMainModule:
  import std/unittest

  suite "required tests":
    test "Raku":
      check reversedVowels("Raku") == "Ruka"
    test "Perl":
      check reversedVowels("Perl") == "Perl"
    test "Julia":
      check reversedVowels("Julia") == "Jaliu"
    test "Uiua":
      check reversedVowels("Uiua") == "Auiu"
