#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 206 Task 1 Shortest Time
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of time points, at least 2, in the 24-hour clock format
# HH:MM. Write a script to find out the shortest time in minutes between any
# two time points.
# Example 1 Input: @time = ("00:00", "23:55", "20:00") Output: 5
#   Since the difference between "00:00" and "23:55" is the shortest
# Example 2 Input: @array = ("01:01", "00:50", "00:57") Output: 4
# Example 3 Input: @array = ("10:10", "09:30", "09:00", "09:55") Output: 15
##
# Example 1 implies that 00:00 can represent midnight either at the start
# of the day, or at the end of the day.  Ambiguous if 24:00 is allowed.
#
# All the interesting times involve midnight.  If all the
# points were within the same day, then a pair like 00:10, 23:50 would be
# 23 hours and 40 minutes long.  But if we allow wrapping around midnight,
# there's only 20 minutes between them.  The problem specification is
# ambiguously silent, except that example with 00:00 kind of implies that
# we should wrap around.
#=============================================================================

use v5.36;

use List::Util qw/min/;

use constant  {
    MINPERDAY => 24 * 60
};

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Map a string in HH:MM format to the minute past midnight.
sub hhmmToMin($hhmm)
{
    my ($hour, $min) = split(':', $hhmm);
    my $minOfDay = $hour * 60 + $min;
    return ($minOfDay == MINPERDAY ? 0 : $minOfDay);
}

sub shortestTime($moments)
{
    my @minutes =  map { hhmmToMin($_) } $moments->@*;

    my $least = MINPERDAY;

    # Do a full NxN scan of every possible pair.  Getting the difference
    # in either direction will wash away the ambiguity of 00:00.
    for ( my $beg = 0 ; $beg <= $#minutes ; $beg++ )
    {
        for ( my $end = 0; $end <= $#minutes ; $end++ )
        {
            next if $end == $beg;
            my $d1 = ( $minutes[$end] - $minutes[$beg] ) % MINPERDAY;
            $least = min($least, $d1 );
        }
    }
    return $least;
}

sub runTest
{
    use Test2::V0;

    is( shortestTime( [ "00:00", "23:55", "20:00" ] ),           5, "Example 1");
    is( shortestTime( [ "01:01", "00:50", "00:57" ] ),           4, "Example 2");
    is( shortestTime( [ "10:10", "09:30", "09:00", "09:55" ] ), 15, "Example 3");

    is( shortestTime( [ "00:02", "23:58", "00:57" ] ),           4, "'round midnight");
    is( shortestTime( [ "00:02", "00:57", "00:02" ] ),           0, "Zero");
    is( shortestTime( [ "23:55", "24:00", "00:02" ] ),           2, "24:00");
    is( shortestTime( [ "23:55", "24:00", "00:07" ] ),           5, "24:00 again");

    done_testing;
}

