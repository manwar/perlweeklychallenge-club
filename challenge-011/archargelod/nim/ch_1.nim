#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/math

const
  CelsiusFreezing = 0
  CelsiusBoiling = 100
  FahrenheitFreezing = 32
  FahrenheitBoiling = 212

proc toFahrenheit(t: int): int =
  let slope =
    (FahrenheitBoiling - FahrenheitFreezing) / (CelsiusBoiling - CelsiusFreezing)
  int round(FahrenheitFreezing.float + slope * float(t - CelsiusFreezing))

proc equalPoint(): int =
  while result.toFahrenheit() > result:
    dec result

when isMainModule:
  import std/unittest

  suite "Equal point in Fahrenheit and Celsius":
    test "-40 is the equal point":
      check equalPoint() == -40
