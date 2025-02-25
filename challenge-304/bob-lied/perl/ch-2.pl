#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 304 Task 2 Maximum Average
#=============================================================================
# You are given an array of integers, @ints and an integer, $n
# which is less than or equal to total elements in the given array.
# Write a script to find the contiguous subarray whose length is the given
# integer, $n, and has the maximum average. It should return the average.
# Example 1 Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
#           Output: 12.75
#   Subarray: (12, -5, -6, 50) Average: (12 - 5 - 6 + 50) / 4 = 12.75
# Example 2 Input: @ints = (5), $n = 1
#           Output: 5
#=============================================================================

use v5.40;
use List::Util qw/sum0/;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $N = 4;

GetOptions("n:i" => \$N, "test" => \$DoTest,
            "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

say maxAvg($N, @ARGV);

#=============================================================================
sub maxAvg($n, @ints)
{
    die "n=$n out of range 1..".scalar(@ints) if ( $n < 0 || $n > scalar(@ints) );
    my $first = $ints[0];
    my $bestSum = my $moving = sum0 @ints[ 0 .. ($n-1) ];
    for my $i ( $n .. $#ints )
    {
        $moving += $ints[$i] - $ints[$i-$n];
        $bestSum = $moving if $moving > $bestSum;
    }
    return $bestSum / $n;
}

sub runTest
{
    use Test2::V0;

    is( maxAvg(4,  12,-5,-6,50), 12.75, "Example 1");
    is( maxAvg(1,            5),     5, "Example 2");

    is( maxAvg(1,  7,9,2,-3,-5),     9, "Degenerate n=1 ==> max");
    is( maxAvg(6,  6,7,8,4,5,6),     6, "Degenerate n=length ==> avg");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
