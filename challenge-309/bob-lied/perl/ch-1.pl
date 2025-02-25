#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 309 Task 1 Min Gap
#=============================================================================
# You are given an array of integers, @ints, increasing order.
# Write a script to return the element before which you find the smallest gap.
# Example 1 Input: @ints = (2, 8, 10, 11, 15)
#           Output: 11
#   @ints: 2   8   10   11   15
#    gaps:   3   2    1    4
#   The minimum of 1 is found before 11.
# Example 2 Input: @ints = (1, 5, 6, 7, 14)
#           Output: 6
#   @ints: 1   5   6   7   14
#    gaps:   4   1   1   7
#   6 and 7 where we found the min gap, so we pick the first instance.
#=============================================================================

use v5.40;

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

say minGap(sort { $a <=> $b } @ARGV);

#=============================================================================
sub minGap(@ints)
{
    return undef if @ints < 2;

    my $minGap = abs($ints[1] - $ints[0]);
    my $place = $ints[1];
    for my $i ( 2 .. $#ints )
    {
        my $gap = abs($ints[$i] - $ints[$i-1]);
        if ( $gap < $minGap )
        {
            $minGap = $gap;
            $place = $ints[$i];
        }
    }
    return $place;
}

sub minGapShift(@ints)
{
    return undef if @ints < 2;
    my $first = shift @ints;
    my $place = my $second = shift @ints;
    my $minGap = abs($second - $first);
    $first = $second;
    while ( defined( my $second = shift @ints ) )
    {
        my $gap = $second - $first;
        if ( $gap < $minGap )
        {
            $minGap = $gap;
            $place = $second;
        }
        $first = $second;
    }
    return $place;
}

sub runTest
{
    use Test2::V0;

    is( minGap(2,8,10,11,15), 11, "Example 1");
    is( minGap(1,5,6,7,14),    6, "Example 2");
    is( minGap(1,2,6,7,14),    2, "Min at start");
    is( minGap(1,4,6,13,14),  14, "Min at end");
    is( minGap(1,4,6,8,10),    6, "Multiple min");

    is( minGapShift(2,8,10,11,15), 11, "Example 1 shift");
    is( minGapShift(1,5,6,7,14),    6, "Example 2 shift");
    is( minGapShift(1,2,6,7,14),    2, "Min at start shift");
    is( minGapShift(1,4,6,13,14),  14, "Min at end shift");
    is( minGapShift(1,4,6,8,10),    6, "Multiple min shift");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
