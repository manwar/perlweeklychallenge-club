#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 274 Task 2 Bus Route
#=============================================================================
# Several bus routes start from a bus stop near my home, and go to the same
# stop in town. They each run to a set timetable, but they take different
# times to get into town.
#
# Write a script to find the times - if any - I should let one bus leave and
# catch a strictly later one in order to get into town strictly sooner.
#
# An input timetable consists of the service interval, the offset within the
# hour, and the duration of the trip.
# Example 1 Input: [ [12, 11, 41], [15, 5, 35] ]
#           Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
#   Route 1 leaves every 12 minutes, starting at 11 minutes past the
#   hour (so 11, 23, ...) and takes 41 minutes. Route 2 leaves every
#   15 minutes, starting at 5 minutes past (5, 20, ...) and takes
#   35 minutes. At 45 minutes past the hour I could take the route 1
#   bus at 47 past the hour, arriving at 28 minutes past the following
#   hour, but if I wait for the route 2 bus at 50 past I will get to
#   town sooner, at 25 minutes past the next hour.
#
# Example 2 Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
#           Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59 ]
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Calculate the next time that $route stops at or after $minute
# $route is a triple of [cycle time, first time, time to destination]
# Returns a pair of [next bus stop time, arrival at destination]
sub nextBusAt($route, $minute)
{
    my ($cycle, $offset, $duration) = $route->@*;

    my $stop = $offset + $cycle * ceil( ($minute - $offset) / $cycle );
    return [ $stop, $stop + $duration ];
}

sub busRoute($timetable)
{
    use List::Util qw/any/;
    my @skipToLater;
    for my $minute ( 0 .. 59 )
    {
        # Convert each route to a pair of [stop, arrive] and
        # sort by next stop time.
        my @next = sort { $a->[0] <=> $b->[0] }
                    map { nextBusAt($_, $minute) } $timetable->@*;

        my ( $firstStopTime, $firstFinishTime) = (shift @next)->@*;

        push @skipToLater, $minute
            if any { $_->[1] < $firstFinishTime
                  && $_->[0] != $firstStopTime } @next;
    }

    return \@skipToLater;
}

sub runTest
{
    use Test2::V0;

    my $route = [12, 11, 41];
    is( nextBusAt($route,  0), [11,  52], "StopsAt  0");
    is( nextBusAt($route,  1), [11,  52], "StopsAt  1");
    is( nextBusAt($route, 11), [11,  52], "StopsAt 11");
    is( nextBusAt($route, 12), [23,  64], "StopsAt 12");
    is( nextBusAt($route, 24), [35,  76], "StopsAt 24");
    is( nextBusAt($route, 36), [47,  88], "StopsAt 36");
    is( nextBusAt($route, 48), [59, 100], "StopsAt 48");
    is( nextBusAt($route, 59), [59, 100], "StopsAt 59");

    is( busRoute( [ [12, 11, 41], [15, 5, 35] ] ), [ 36 .. 47 ] , "Example 1");
    is( busRoute( [ [12,  3, 41], [15, 9, 35], [30, 5, 25] ] ),
        [0..3, 25..27, 40..51, 55..59 ] , "Example 2");

    done_testing;
}
