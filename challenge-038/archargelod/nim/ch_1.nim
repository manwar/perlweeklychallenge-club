#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/strutils

proc formattedDate(date: string): string =
  template throwError =
    raise newException(ValueError, "Invalid date format, use: (0-1)(00-99)(01-12)(01-31)")

  if date.len != 7:
    throwError()

  # year
  case date[0]
  of '1': result.add "20"
  of '2': result.add "19"
  else:
    throwError()

  if {date[1], date[2]} <= Digits:
    result.add date[1] & date[2]
  else:
    throwError()

  try:
    # month
    if parseInt(date[3] & date[4]) in 1..12:
      result.add '-' & date[3] & date[4]
    else:
      throwError()

    # day
    if parseInt(date[5] & date[6]) in 1..31:
      result.add '-' & date[5] & date[6]
    else:
      throwError()
  except ValueError:
    throwError()

when isMainModule:
  import std/unittest

  const
    Test = "2230120"
    Expected = "1923-01-20"

  suite "Date parser":
    test "Example 1":
      check formattedDate(Test) == Expected
