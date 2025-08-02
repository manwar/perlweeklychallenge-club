#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off

proc ackermann(m, n: Natural): int =
  if m == 0:
    n + 1
  elif n == 0:
    ackermann(m - 1, 1)
  else:
    ackermann(m - 1, ackermann(m, n - 1))

when isMainModule:
  import std/unittest

  suite "Ackermann function":
    test "A(1, 2) == 4":
      check ackermann(1, 2) == 4
