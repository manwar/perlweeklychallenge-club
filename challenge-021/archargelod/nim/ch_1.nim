#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import pkg/mapm

proc approximateE(precision: int): Mapm =
  let n = 1e41'm
  pow(1'm + divide(1'm, n, precision), n, precision).round(precision)

when isMainModule:
  import std/unittest

  const
    Expected = "2.7182818284590452353602874713526624977572"

  suite "Euler's number":
    test "40-digit precision":
      check $approximateE(40) == Expected
