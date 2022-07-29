use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 175
=========================

TASK #1
-------
*Last Sunday*

Submitted by: Mohammad S Anwar

Write a script to list Last Sunday of every month in the given year.

For example, for year 2022, we should get the following:

  2022-01-30
  2022-02-27
  2022-03-27
  2022-04-24
  2022-05-29
  2022-06-26
  2022-07-31
  2022-08-28
  2022-09-25
  2022-10-30
  2022-11-27
  2022-12-25

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
All dates are interpreted according to the Gregorian calendar [2,3]. Dates
prior to 15th October, 1582, when the Gregorian calendar was first introduced,
are calculated according to the "proleptic Gregorian calendar" [3] which
extends backwards to dates before the calendar was in use. However, dates prior
to the year 1 AD are not supported.

Solution
--------
The solution uses Raku's native Date class [1]. Its constructor accepts a "*"
as the argument to its "day" parameter: this gives the last day in the month,
automatically finding the last day of February as 28 or 29, according to
whether or not the year is a leap year.

Then, Date's day-of-week() method finds the weekday of the last day in the
month: it "[r]eturns the day of the week, where 1 is Monday, 2 is Tuesday and
Sunday is 7." [1] If the last day is a Monday, then the last Sunday is one day
prior; if a Tuesday, it is two days prior; and so on. Hence, the date of the
last Sunday is calculated by subtracting from the date of the last day the
weekday of the last day modulo 7.

References
----------
[1] "class Date", Raku Documentation, https://docs.raku.org/type/Date
[2]  Claus Tøndering, "The Gregorian calendar", The Calendar FAQ,
     https://www.tondering.dk/claus/cal/gregorian.php
[3] "Gregorian calendar", Wikipedia,
     https://en.wikipedia.org/wiki/Gregorian_calendar

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 175, Task #1: Last Sunday (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $year where * > 0           #= A year in the Gregorian calendar (AD)
)
#==============================================================================
{
    "The last Sunday of each month in the year $year:\n".put;

    for 1 .. 12 -> UInt $month
    {
        my Date $last-day = Date.new: $year, $month, *;
        my Date $last-sun = Date.new: $last-day - ($last-day.day-of-week % 7);

        "  { $last-sun.Str }".put;
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
