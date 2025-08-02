#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import pkg/mapm # `$ nimble install mapm`

let approxR* = pow(640_320'M, 3) + 744'M - divide(75'M, 100_000_000_000_000'M, 16)

when isMainModule:
  import std/unittest

  suite "Ramanujan's constant":
    test "32-digit approximation":
      check $approxR == "262537412640768743.99999999999925"
