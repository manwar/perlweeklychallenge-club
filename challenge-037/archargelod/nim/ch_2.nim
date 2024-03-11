#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
# Notes: Vim and AWK had done 99% of work here.
import std/times

const
  DecemberDaylight = [
    initDuration(hours = 8, minutes = 11, seconds = 53),
    initDuration(hours = 8, minutes = 09, seconds = 53),
    initDuration(hours = 8, minutes = 07, seconds = 57),
    initDuration(hours = 8, minutes = 06, seconds = 07),
    initDuration(hours = 8, minutes = 04, seconds = 22),
    initDuration(hours = 8, minutes = 02, seconds = 42),
    initDuration(hours = 8, minutes = 01, seconds = 08),
    initDuration(hours = 7, minutes = 59, seconds = 40),
    initDuration(hours = 7, minutes = 58, seconds = 17),
    initDuration(hours = 7, minutes = 57, seconds = 01),
    initDuration(hours = 7, minutes = 55, seconds = 50),
    initDuration(hours = 7, minutes = 54, seconds = 45),
    initDuration(hours = 7, minutes = 53, seconds = 46),
    initDuration(hours = 7, minutes = 52, seconds = 54),
    initDuration(hours = 7, minutes = 52, seconds = 08),
    initDuration(hours = 7, minutes = 51, seconds = 28),
    initDuration(hours = 7, minutes = 50, seconds = 54),
    initDuration(hours = 7, minutes = 50, seconds = 27),
    initDuration(hours = 7, minutes = 50, seconds = 06),
    initDuration(hours = 7, minutes = 49, seconds = 52),
    initDuration(hours = 7, minutes = 49, seconds = 44),
    initDuration(hours = 7, minutes = 49, seconds = 43),
    initDuration(hours = 7, minutes = 49, seconds = 49),
    initDuration(hours = 7, minutes = 50, seconds = 01),
    initDuration(hours = 7, minutes = 50, seconds = 19),
    initDuration(hours = 7, minutes = 50, seconds = 44),
    initDuration(hours = 7, minutes = 51, seconds = 15),
    initDuration(hours = 7, minutes = 51, seconds = 53),
    initDuration(hours = 7, minutes = 52, seconds = 37),
    initDuration(hours = 7, minutes = 53, seconds = 28),
    initDuration(hours = 7, minutes = 54, seconds = 24),
  ]

  NovemberDaylight = [
    initDuration(hours = 9, minutes = 40, seconds = 44),
    initDuration(hours = 9, minutes = 37, seconds = 10),
    initDuration(hours = 9, minutes = 33, seconds = 38),
    initDuration(hours = 9, minutes = 30, seconds = 07),
    initDuration(hours = 9, minutes = 26, seconds = 38),
    initDuration(hours = 9, minutes = 23, seconds = 11),
    initDuration(hours = 9, minutes = 19, seconds = 45),
    initDuration(hours = 9, minutes = 16, seconds = 22),
    initDuration(hours = 9, minutes = 13, seconds = 01),
    initDuration(hours = 9, minutes = 09, seconds = 42),
    initDuration(hours = 9, minutes = 06, seconds = 25),
    initDuration(hours = 9, minutes = 03, seconds = 11),
    initDuration(hours = 8, minutes = 59, seconds = 59),
    initDuration(hours = 8, minutes = 56, seconds = 50),
    initDuration(hours = 8, minutes = 53, seconds = 44),
    initDuration(hours = 8, minutes = 50, seconds = 40),
    initDuration(hours = 8, minutes = 47, seconds = 39),
    initDuration(hours = 8, minutes = 44, seconds = 42),
    initDuration(hours = 8, minutes = 41, seconds = 48),
    initDuration(hours = 8, minutes = 38, seconds = 57),
    initDuration(hours = 8, minutes = 36, seconds = 09),
    initDuration(hours = 8, minutes = 33, seconds = 25),
    initDuration(hours = 8, minutes = 30, seconds = 45),
    initDuration(hours = 8, minutes = 28, seconds = 09),
    initDuration(hours = 8, minutes = 25, seconds = 36),
    initDuration(hours = 8, minutes = 23, seconds = 08),
    initDuration(hours = 8, minutes = 20, seconds = 44),
    initDuration(hours = 8, minutes = 18, seconds = 24),
    initDuration(hours = 8, minutes = 16, seconds = 09),
    initDuration(hours = 8, minutes = 13, seconds = 59),
  ]

proc diff(a, b: openarray[Duration]): Duration =
  for d in a:
    result += d
  for d in b:
    result -= d

proc main() =
  let dayLightLoss = abs(diff(DecemberDaylight, NovemberDaylight))
  echo "December had lost ", dayLightLoss, " of daylight, compared to November in 2019, London."

when isMainModule:
  main()
