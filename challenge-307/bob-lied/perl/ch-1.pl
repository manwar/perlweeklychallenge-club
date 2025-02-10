#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 307 Task 1 Check Order
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to re-arrange the given array in an increasing order and
# return the indices where it differs from the original array.
# Example 1 Input: @ints = (5, 2, 4, 3, 1)
#           Output: (0, 2, 3, 4)
#   Before: (5, 2, 4, 3, 1)
#   After : (1, 2, 3, 4, 5)
#   Difference at indices: (0, 2, 3, 4)
# Example 2 Input: @ints = (1, 2, 1, 1, 3)
#           Output: (1, 3)
#   Before: (1, 2, 1, 1, 3)
#   After : (1, 1, 1, 2, 3)
#   Difference at indices: (1, 3)
# Example 3 Input: @ints = (3, 1, 3, 2, 3)
#           Output: (0, 1, 3)
#   Before: (3, 1, 3, 2, 3)
#   After : (1, 2, 3, 3, 3)
#   Difference at indices: (0, 1, 3)
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

say '(', join(', ', checkOrder(@ARGV)->@*), ')';

#=============================================================================
sub checkOrder(@ints)
{
    my @sorted = sort { $a <=> $b } @ints;
    return [ grep { $ints[$_] != $sorted[$_] } 0 .. $#ints ];
}

sub runTest
{
    use Test2::V0;

    is( checkOrder(5,2,4,3,1), [0,2,3,4], "Example 1");
    is( checkOrder(1,2,1,1,3), [1,3    ], "Example 2");
    is( checkOrder(3,1,3,2,3), [0,1,3  ], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
