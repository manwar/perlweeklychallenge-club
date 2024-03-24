#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, parseutils]

type RomanDigit = enum
  I = 1
  V = 5
  X = 10
  L = 50
  C = 100
  D = 500
  M = 1000

const
  Squish = {
    "VIIII": "IX",
    "LXXXX": "XC",
    "DCCCC": "CM",
    "IIII": "IV",
    "XXXX": "XL",
    "CCCC": "CD",
  }

const RomanDescending = [M, D, C, L, X, V, I]

proc toRoman(dec: int): string =
  var dec = dec
  while dec > 0:
    for roman in RomanDescending:
      if dec >= roman.ord:
        dec -= roman.ord
        result &= $roman
        break

  for (sub, by) in Squish:
    result = result.replace(sub, by)

proc toDec(roman: string): int =
  var prev = M
  for c in roman:
    let r = parseEnum[RomanDigit]($c)
    result += r.ord
    if prev < r:
      result -= prev.ord * 2
    prev = r

proc romanCalculator(input: string): string =
  let tmp = input.splitWhitespace()
  assert tmp.len == 3
  let (arg1, op, arg2) = (tmp[0], tmp[1], tmp[2])

  toRoman(
    case op
    of "+": toDec(arg1) + toDec(arg2)
    of "-": toDec(arg1) - toDec(arg2)
    of "*": toDec(arg1) * toDec(arg2)
    else:
      raiseAssert("Invalid expression")
  )

when isMainModule:
  import std/unittest

  const
    Test = [
      "XXXVI + X",
      "DIV - X",
      "VII * X",
    ]
    Expected = [
      "XLVI",
      "CDXCIV",
      "LXX",
    ]

  suite "Show multiple arrays content":
    test "Addition":
      check romanCalculator(Test[0]) == Expected[0]
    test "Subtraction":
      check romanCalculator(Test[1]) == Expected[1]
    test "Multiplication":
      check romanCalculator(Test[2]) == Expected[2]
