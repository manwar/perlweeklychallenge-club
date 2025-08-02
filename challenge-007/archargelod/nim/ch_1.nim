#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc sumOfDigits(n: int): int =
  for d in $n:
    result += d.ord - '0'.ord

proc allNivenNumbers(range: HSlice[int, int]): seq[int] =
  for n in max(1, range.a) .. range.b:
    if n mod sumOfDigits(n) == 0:
      result.add n

when isMainModule:
  import std/[unittest]

  const Expected = [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 18, 20, 21, 24, 27, 30, 36, 40, 42, 45, 48, 50
  ]

  suite "Niven numbers":
    test "niven numbers 0 to 50":
      check allNivenNumbers(0 .. 50) == Expected
