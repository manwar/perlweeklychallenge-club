#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 367 Task 2  Conflict Events
#=============================================================================
# You are given two events start and end time.
# Write a script to find out if there is a conflict between the two events.
# A conflict happens when two events have some non-empty intersection.
# Example 1 Input: @event1 = ("10:00", "12:00") @event2 = ("11:00", "13:00")
#			Output: true
# Example 2 Input: @event1 = ("09:00", "10:30") @event2 = ("10:30", "12:00")
#			Output: false
# Example 3 Input: @event1 = ("14:00", "15:30") @event2 = ("14:30", "16:00")
#			Output: true
# Example 4 Input: @event1 = ("08:00", "09:00") @event2 = ("09:01", "10:00")
#			Output: false
# Example 5 Input: @event1 = ("23:30", "00:30") @event2 = ("00:00", "01:00")
#			Output: true
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub isConflict($event1, $event2)
{
    return isOverlap(toRange( map { toMinute($_) } $event1->@* ),
                     toRange( map { toMinute($_) } $event2->@* ) );
}

sub isOverlap($range1, $range2)
{
    use enum qw( BEG=0 END=1 );
    return $range1->[END] > $range2->[BEG] && $range1->[BEG] < $range2->[END];
}

sub toRange($minBeg, $minEnd)
{
    my $duration = ($minEnd - $minBeg) % 1440;
    return [ $minEnd - $duration, $minEnd ];
}

sub toMinute($hhmm)
{
    my ($h, $m) = split(":", $hhmm);
    my $minute = $m + 60 * $h;
    return $minute;
}

sub runTest
{
    use Test2::V0;

    is( toMinute("00:00"),    0, "Minute 00:00");
    is( toMinute("00:59"),   59, "Minute 00:59");
    is( toMinute("10:00"),  600, "Minute 10:00");
    is( toMinute("23:59"), 1439, "Minute 23:59");

    is( toRange(0, 0), [0,0], "Range 0,0");
    is( toRange(60, 120), [60,120], "Range 0,0");
    is( toRange(0, 1439), [0,1439], "Range 0,1439");
    is( toRange(1410, 30), [-30,30], "Range 1410,30 over midnight");


    is( isConflict(["10:00", "12:00"] , ["11:00", "13:00"]),  true, "Example 1");
    is( isConflict(["09:00", "10:30"] , ["10:30", "12:00"]), false, "Example 2");
    is( isConflict(["14:00", "15:30"] , ["14:30", "16:00"]),  true, "Example 3");
    is( isConflict(["08:00", "09:00"] , ["09:01", "10:00"]), false, "Example 4");
    is( isConflict(["23:30", "00:30"] , ["00:00", "01:00"]),  true, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
