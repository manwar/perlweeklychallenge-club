#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 237 Task 1 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Given a year, a month, a weekday of month, and a day of week
# (1 (Mon) .. 7 (Sun)), print the day.
# Example 1
#   Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
#   Output: 16
#   The 3rd Tue of Apr 2024 is the 16th
# Example 2
#   Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
#   Output: 9
#   The 2nd Thu of Oct 2025 is the 9th
# Example 3
#   Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
#   Output: 0
#   There isn't a 5th Wed in Aug 2026
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use DateTime;
use DateTime::Duration;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub seizeTheDay(%day)
{
    my $dt = DateTime->new(year => $day{year}, month => $day{month}, day=>1);

    my $lastDayOfMonth = DateTime->last_day_of_month( year => $day{year}, month => $day{month} );

    # Move forward until we reach the right day of the week.
    while ( $dt->day_of_week != $day{dow} )
    {
        $dt->add( days => 1);
    }

    # Move forward by weeks
    my $weekOfMonth = 1;
    while ( $weekOfMonth < $day{week} && $dt->day <= ($lastDayOfMonth->day - 7) )
    {
        $dt->add( days=> 7 );
        $weekOfMonth++;
    }

    return ( $weekOfMonth == $day{week} ) ? $dt->day : 0;
}

sub runTest
{
    use Test2::V0;

    is( seizeTheDay( year=>2024, month=> 4, week=>3, dow=>2), 16, "Example 1");
    is( seizeTheDay( year=>2025, month=>10, week=>2, dow=>4),  9, "Example 2");
    is( seizeTheDay( year=>2026, month=> 8, week=>5, dow=>3),  0, "Example 3");

    is( seizeTheDay( year=>2023, month=>10, week=>1, dow=>7),  1, "First sunday");
    is( seizeTheDay( year=>2023, month=> 9, week=>5, dow=>6), 30, "Last saturday");

    done_testing;
}
