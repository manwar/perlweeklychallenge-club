#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
import std/[times, strformat, math]

proc lastWeekdayOfEveryMonth(weekDay: WeekDay, year: int): seq[string] =
  for month in Month:
    let
      lastMonthDay = getDaysInMonth(month, year)
      lastWeekDay = getDayOfWeek(lastMonthDay, month, year).ord
      lastFriday = lastMonthDay - euclmod(lastWeekDay - weekDay.ord, 7)

    result.add &"{year:04}/{month.ord:02}/{lastFriday:02}"

when isMainModule:
  import std/unittest

  suite "Last Fridays of every month":
    test "last Fridays of 2019":
      check lastWeekdayOfEveryMonth(dFri, 2019) == [
        "2019/01/25", "2019/02/22", "2019/03/29", "2019/04/26", "2019/05/31",
        "2019/06/28", "2019/07/26", "2019/08/30", "2019/09/27", "2019/10/25",
        "2019/11/29", "2019/12/27"
      ]
