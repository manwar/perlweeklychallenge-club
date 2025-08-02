#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/times

proc main() =
  for year in 2019..2100:
    let weekDay = getDayOfWeek(31, mDec, year)
    let day = 31 - (weekDay.ord + 1) mod 7
    echo day, " ", mDec, " ", year, " is Sunday"

when isMainModule:
  main()
