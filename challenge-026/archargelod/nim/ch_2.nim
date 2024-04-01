#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[math, sequtils]

proc circularMean(degrees: varargs[float, toFloat]): float =
  let radians = degrees.mapIt(it.degToRad)

  let sinSum = radians.mapIt(it.sin).sum()
  let cosSum = radians.mapIt(it.cos).sum()

  arctan2(sinSum, cosSum).radToDeg.euclMod(360)

when isMainModule:
  import std/unittest

  const
    Test = [@[180.0, 200.0], @[355.0, 5.0, 15.0]]
    Expected = [190.0, 5.0]

  suite "Mean angles":
    test "180, 200 -> 190":
      check almostEqual(Test[0].circularMean(), Expected[0])
    test "355, 5, 15 -> 5":
      check almostEqual(Test[1].circularMean(), Expected[1])
