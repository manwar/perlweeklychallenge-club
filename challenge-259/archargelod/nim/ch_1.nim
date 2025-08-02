#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/times

proc bankingDay(
    date: DateTime, offset: int, holidays: openarray[DateTime] = @[]
): DateTime =
  result = date

  var offset = offset
  while offset > 0:
    result += 1.days
    if result.weekday notin {dSat, dSun} and result notin holidays:
      dec offset

when isMainModule:
  import std/unittest

  let
    Test: seq[tuple[start: DateTime, offset: int, holidays: seq[DateTime]]] = @[
      (dateTime(2018, mJun, 28), 3, @[dateTime(2018, mJul, 3)]),
      (dateTime(2018, mJun, 28), 3, @[]),
    ]
    Expected = [
      dateTime(2018, mJul, 4),
      dateTime(2018, mJul, 3),
    ]

  suite "Banking Day Offset":
    test "Example 1":
      check bankingDay(Test[0].start, Test[0].offset, Test[0].holidays) == Expected[0]
    test "Example 2":
      check bankingDay(Test[1].start, Test[1].offset, Test[1].holidays) == Expected[1]
