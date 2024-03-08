#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/times

proc findSmallestMultiple(x, max: int, offset = 0): tuple[count, number: int] =
  ## Find the smallest number, greater than or equal to max
  ## that is divisible by x
  let max0 = max - offset
  let smallestK =
    if max0 mod x == 0:
      max0 div x
    else:
      max0 div x + 1

  (smallestK+1, x * smallestK + offset)

proc main =
  const Year = 2019
  for month in Month:
    let monthDays = getDaysInMonth(month, Year)
    let firstSunday = abs(7 - getDayOfWeek(1, month, Year).ord)
    let (weekEnds, lastSunday) = findSmallestMultiple(7, monthDays, offset = firstSunday)

    var weekDays = weekEnds * 2

    if firstSunday == 1:
      dec weekDays # remove first saturday

    if lastSunday > monthDays:
      dec weekDays # remove last sunday
      if lastSunday - 1 > monthDays:
        dec weekDays # remove last saturday

    echo month, ": ", monthDays - weekDays, " days"


when isMainModule:
  main()
