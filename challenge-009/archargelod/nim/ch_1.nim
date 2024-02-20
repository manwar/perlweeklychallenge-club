#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
proc distinctDigitsCount(number: int): int =
  var digits: set[char]
  for d in $number:
    if d notin digits:
      digits.incl d
  digits.len

proc findSquareNDistinctDigits*(digits: range[1 .. 10]): int =
  var n = 1
  while result.distinctDigitsCount < digits:
    result = n * n
    inc n

when isMainModule:
  import std/unittest
  suite "Square with 5 distinct digits":
    test "12769 is the first square with 5 distinct digits":
      check findSquareNDistinctDigits(5) == 12769
