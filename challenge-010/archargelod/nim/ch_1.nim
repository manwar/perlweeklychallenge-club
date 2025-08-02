#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/tables

type RomanNumeral = string

const
  validRomanDigits = "IVXLCDM"
  RomanToDec = {
    "M": 1000,
    "CM": 900,
    "D": 500,
    "CD": 400,
    "C": 100,
    "XC": 90,
    "L": 50,
    "XL": 40,
    "X": 10,
    "IX": 9,
    "V": 5,
    "IV": 4,
    "I": 1
  }.toOrderedTable

proc toRoman*(number: 1 .. 3999): RomanNumeral =
  var number: int = number
  while number > 0:
    for roman, dec in RomanToDec:
      if number >= dec:
        number -= dec
        result.add roman
        break

proc toDec*(roman: RomanNumeral): int =
  if roman.len < 1:
    raise newException(ValueError, "Invalid roman numeral")
  var prev = int.high
  for romanDigit in roman:
    if romanDigit notin validRomanDigits:
      raise newException(ValueError, "Invalid roman numeral")
    let cur = RomanToDec[$romanDigit]
    if cur > prev:
      result -= prev * 2
    result += cur
    prev = cur

  if result notin 0 .. 3999:
    raise newException(ValueError, "Invalid roman numeral")

when isMainModule:
  import std/unittest

  const
    TestNumber = 246
    Expected = "CCXLVI"

  suite "Roman numeral encode/decode":
    test "246 should be CCXLVI":
      check TestNumber.toRoman == Expected
    test "number encoded then decoded equals itself":
      check TestNumber.toRoman.toDec == TestNumber
    test "roman numerals with invalid digits are invalid":
      expect ValueError:
        discard "Hello".toDec
    test "roman numerals outside of range 1..3999 are invalid":
      expect ValueError:
        discard "MMMMMMM".toDec
