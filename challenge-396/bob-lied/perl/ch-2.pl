#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 396 Task 2  Trionic Array
#=============================================================================
# You are given an array of integer.  Write a script to return true if the
# given array is Trionic otherwise return false.  An array is trionic if there
# exist indices 0 < p < q < n − 1 such that arr[0…p] is strictly increasing,
# arr[p…q] is strictly decreasing, and arr[q…n − 1] is strictly increasing.
# Example 1 Input: @arr = (1, 3, 5, 4, 2, 6, 8)
#           Output: true
#   $arr[0..2] = (1, 3, 5) (strictly increasing)
#   $arr[2..4] = (5, 4, 2) (strictly decreasing)
#   $arr[4..6] = (2, 6, 8) (strictly increasing)
#   Valid indices: 0 < p (2) < q (4) < n-1 (6).
# Example 2 Input: @arr = (1, 4, 4, 2, 1, 3, 5)
#           Output: false
#   The first segment (1, 4, 4) contains duplicate adjacent values, so it is
#   not strictly increasing.  No valid p and q exist to satisfy all three
#   strictly monotonic conditions.
# Example 3 Input: @arr = (2, 10, 3, 1, 9)
#           Output: true
#   $arr[0..1] = (2, 10)    (strictly increasing)
#   $arr[1..3] = (10, 3, 1) (strictly decreasing)
#   $arr[3..4] = (1, 9)     (strictly increasing)
# Example 4 Input: @arr = (1, 2, 3, 4, 3, 2, 1)
#           Output: false
#   This is a standard mountain array (strictly increasing, then strictly
#   decreasing). There is no second valley (q) that transitions back into
#   a strictly increasing third segment before reaching the end of the array.
# Example 5 Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
#           Output: false
#=============================================================================

use v5.44;


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

say task(@ARGV) ? "true" : "false";

#=============================================================================
sub task(@arr)
{
    return false if @arr < 4
                 || $arr[0]  >= $arr[1]
                 || $arr[-2] >= $arr[-1];

    my ($peak, $valley) = (0, 0);
    for my $i ( 1 .. $#arr-1 )
    {
        $peak++   if $arr[$i-1] < $arr[$i] && $arr[$i] > $arr[$i+1];
        $valley++ if $arr[$i-1] > $arr[$i] && $arr[$i] < $arr[$i+1];
    }
    return $peak == 1 && $valley == 1;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(   1, 3, 5, 4, 2, 6, 8),  true, "Example 1");
    is( task(   1, 4, 4, 2, 1, 3, 5), false, "Example 2");
    is( task(        2, 10, 3, 1, 9),  true, "Example 3");
    is( task(   1, 2, 3, 4, 3, 2, 1), false, "Example 4");
    is( task(1, 3, 6, 4, 2, 7, 8, 4), false, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

