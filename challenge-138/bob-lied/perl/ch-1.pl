#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge, Week 138, Task #1 Workdays
# You are given a year, $year in 4-digits form.  Write a script to calculate
# the total number of workdays in the given year.  For the task, we consider,
# Monday - Friday as workdays.
#=============================================================================

use strict;
use warnings;
use v5.32;

use DateTime;

use experimental qw/ signatures /;
no warnings "experimental::signatures";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

# Assuming a modern Gregorian calendar of 365 or 366 days,
# with regular leap years, there are 52 weeks (52*7 = 364)
# of five work days, and one or two extra days.  In a 365-day
# year, the 365th day will be the same day of the week as the
# 1st day.  In a 366-day week, the two extra days will be the
# same day as 1st and 2nd..
#
# So there are two cases.  For 365-day years, a year that starts
# on a workday will end on the same workday, for a total of 261.
# A year that starts on Saturday or Sunday will end on Saturday
# or Sunday for a total of 260.
#
# For a leap year, if it starts on Monday through Thursday, days
# 365 and 366 will also be work days.  If it starts on Friday,
# day 365 will be a work day, but 366 is on a Saturday.  If it
# starts on Saturday, days 365 and 366 will be a weekend.  If it
# starts on a Sunday, day 365 will be Sunday, but 366 will be
# a Monday.
#
# The extra days can be summarized in a 2x7 table, where the first
# index is 0 or 1 for leap year or not; and columns 1 to 7 correspond
# to days of the week with 1 == Monday. (Ignoring index 0 because
# this 1-through-7 is the way that DateTime counts.)

my @extraDays = (
  #   x  M  T  W  T  F  S S
    [ 0, 1, 1, 1, 1, 1, 0, 0 ],    # 0 == not a leap year
    [ 0, 2, 2, 2, 2, 1, 0, 1 ],    # 1 == leap year
);

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $Year = shift;
die "Usage: $0 YYYY" unless $Year;

say workDays($Year);


sub isLeapYear($year)
{
    return ( ($year % 400 == 0) || ( $year % 4 == 0 && $year % 100 != 0 ) ) ? 1 : 0;
}

sub workDays($year)
{
    my $jan1 = DateTime->new(year => $year, month => 1, day => 1);
    my $dayOfWeek = $jan1->day_of_week(); # Returns 1==Monday, 7==Sunday
    my $isLeapYear = isLeapYear($year);
    return 260 + $extraDays[$isLeapYear][$dayOfWeek];
}

sub runTest
{
    use Test::More;

    is( workDays(1900), 261, "Monday    1900");
    is( workDays(2002), 261, "Tuesday   2002");
    is( workDays(2003), 261, "Wednesday 2003");
    is( workDays(2004), 262, "Thursday  2004");
    is( workDays(2021), 261, "Friday    2021");
    is( workDays(1938), 260, "Saturday  1938");
    is( workDays(1989), 260, "Sunday    1989");

    is( workDays(1968), 262, "Monday    1968 LY");
    is( workDays(1952), 262, "Tuesday   1958 LY");
    is( workDays(1908), 262, "Wednesday 1908 LY");
    is( workDays(2004), 262, "Thursday  2004 LY");
    is( workDays(1960), 261, "Friday    1960 LY");
    is( workDays(1972), 260, "Saturday  1972 LY");
    is( workDays(1928), 261, "Sunday    1928 LY");

    done_testing;
}

