#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[strutils, times, algorithm]
type
  TimeRange = HSlice[Time, Time]

proc parseGuestBook(input: string): seq[TimeRange] =
  for line in input.splitLines():
    let fields = line.splitWhitespace()
    let (inTime, outTime) = (fields[3], fields[5])

    result.add parseTime(inTime, "HH:mm", utc())..parseTime(outTime, "HH:mm", utc())

proc mergeOverlaps[T](input: openarray[HSlice[T,T]]): seq[HSlice[T,T]] =
  let input = input.sortedByIt(it.a)
  result.add input[0]
  for range in input[1..^1]:
    if range.a <= result[^1].b:
      result[^1].b = range.b
    else:
      result.add range

proc guestHouseLightDuration*(guestBook: string): Duration =
  var timeIntervals = guestBook.parseGuestBook().mergeOverlaps()

  for interval in timeIntervals:
    result += interval.b - interval.a

when isMainModule:
  import std/unittest

  const
    Test = """
1) Alex    IN: 09:10 OUT: 09:45
2) Arnold  IN: 09:15 OUT: 09:33
3) Bob     IN: 09:22 OUT: 09:55
4) Charlie IN: 09:25 OUT: 10:05
5) Steve   IN: 09:33 OUT: 10:01
6) Roger   IN: 09:44 OUT: 10:12
7) David   IN: 09:57 OUT: 10:23
8) Neil    IN: 10:01 OUT: 10:19
9) Chris   IN: 10:10 OUT: 11:00"""
    Expected = initDuration(minutes = 110)

  suite "Guest house lights":
    test "Example 1":
      check guestHouseLightDuration(Test) == Expected

