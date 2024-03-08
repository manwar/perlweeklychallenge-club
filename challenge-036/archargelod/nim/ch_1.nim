#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, tables]

const
  Weights = [8, 7, 6, 5, 4, 3, 2, 10, 0, 9, 8, 7, 6, 5, 4, 3, 2]
  TranslitTable = {
    'A':1, 'B':2, 'C':3, 'D':4, 'E':5, 'F':6, 'G':7, 'H':8,
    'J':1, 'K':2, 'L':3, 'M':4, 'N':5,        'P':7,        'R':9,
           'S':2, 'T':3, 'U':4, 'V':5, 'W':6, 'X':7, 'Y':8, 'Z':9,
  }.toTable()

proc isValidVIN(input: string): bool =
  if input.len != 17: return false

  var values: array[17, int]
  for i, c in input:
    if i == 8: continue # skip check digit
    if c in Letters:
      values[i] = TranslitTable[c]
    elif c in Digits:
      values[i] = c.ord - '0'.ord
    else:
      return false

  var productSum: int
  for i, v in values:
    productSum += v * Weights[i]

  let checkDigit = block:
    let tmp = productSum mod 11
    if tmp == 10: 'X'
    else: chr('0'.ord + tmp)

  checkDigit == input[8]

when isMainModule:
  import std/unittest

  const
    Test = ["5GZCZ43D13S812715", "1M8GDM9ASKP042788"]
    Expected = [true, false]

  suite "Vehicle Identification Numbers":
    test "valid number":
      check isValidVIN(Test[0]) == Expected[0]
    test "invalid number":
      check isValidVIN(Test[1]) == Expected[1]
