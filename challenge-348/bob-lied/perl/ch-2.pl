#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 348 Task 2  Convert Time
#=============================================================================
# You are given two strings, $source and $target, containing time in 24-hour
# time form. Write a script to convert the source into target by performing
# one of the following operations:
#   1. Add  1 minute
#   2. Add  5 minutes
#   3. Add 15 minutes
#   4. Add 60 minutes
# Find the total operations needed to get to the target.
# Example 1 Input: $source = "02:30" $target = "02:45"
#           Output: 1
#   Just one operation i.e. "Add 15 minutes".
# Example 2 Input: $source = "11:55" $target = "12:15"
#           Output: 2
#   Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".
# Example 3 Input: $source = "09:00" $target = "13:00"
#           Output: 4
#   Four operations of "Add 60 minutes".
# Example 4 Input: $source = "23:45" $target = "00:30"
#           Output: 3
#   Three operations of "Add 15 minutes".
# Example 5 Input: $source = "14:20" $target = "15:25"
#           Output: 2
#   Two operations, one "Add 60 minutes" and one "Add 5 minutes"
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

say convert(@ARGV);

#=============================================================================
sub convert($source, $target)
{
    use Time::Piece;

    my $s = Time::Piece->strptime($source, "%H:%M");
    my $t = Time::Piece->strptime($target, "%H:%M");
    my $min = ($t - $s)->minutes;
    if ( $min <  0 )
    {
        $min += 24*60;
    }
    $logger->debug("src: ", $s, "\ttrg: ", $t, "\tmin=$min");

    my $count = 0;
    for my $period ( 60, 15, 5, 1 )
    {
        $count += int($min / $period);
        $min %= $period;
        $logger->debug("$period: $count\tmin=$min");
    }

    return $count;
}

sub runTest
{
    use Test2::V0;

    is( convert("02:30", "02:45"), 1, "Example 1");
    is( convert("11:55", "12:15"), 2, "Example 2");
    is( convert("09:00", "13:00"), 4, "Example 3");
    is( convert("23:45", "00:30"), 3, "Example 4");
    is( convert("14:20", "15:25"), 2, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
