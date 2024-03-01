#!/usr/bin/env -S nim r -d:release --verbosity:0 --hints:off
##  The only way for a month to have 5 full weekends (Fri, Sat, Sun) is
##  to be 31 days long and start on Friday:
##
##  .... 567
##  1234 567
##  1234 567
##  1234 567
##  1234 567
import std/[times]

for year in 1900..2019:
  for month in Month:
    if getDaysInMonth(month, year) == 31 and
      getDayOfWeek(1, month, year) == dFri:
        echo ($month)[0..2], '-', year
