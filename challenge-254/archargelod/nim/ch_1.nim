#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

proc isPower(n, power: Natural): bool =
  let root = round pow(n.float, 1 / power)
  almostEqual(n.float, pow(root, power.float))

when isMainModule:
  import std/unittest

  suite "required tests":
    test "27 is power of 3":
      check 27.isPower(3)
    test "0 is power of 3":
      check 0.isPower(3)
    test "6 is not a power of 3":
      check not 6.isPower(3)
