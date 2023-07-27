#!/usr/bin/env kotlin

/*
 * You are given a year number in the range 1753 to 9999.  Write a script to
 * find out how many dates in the year are Friday 13th.  Assume that the
 * current Gregorian calendar applies.
 */

import java.time.DayOfWeek
import java.time.LocalDate

fun friday13th(year: Int): List<LocalDate> =
    (1..12).map { month ->
        LocalDate.of(year, month, 13)
    }.filter { date ->
        date.dayOfWeek == DayOfWeek.FRIDAY
    }

println(friday13th(1753).size)
println(friday13th(2023).size)
println(friday13th(9999).size)
