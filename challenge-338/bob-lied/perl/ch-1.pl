#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 338 Task 1  Highest Row
#=============================================================================
# You are given a m x n matrix.
# Write a script to find the highest row sum in the given matrix.
# Example 1 Input: @matrix = ([4,  4, 4, 4],
#           Output: 16        [10, 0, 0, 0],
#                             [2,  2, 2, 9])
# Example 2 Input: @matrix = ([1, 5],
#           Output: 10        [7, 3],
#                             [3, 5])
# Example 3 Input: @matrix = ([1, 2, 3],
#           Output: 6         [3, 2, 1])
# Example 4 Input: @matrix = ([2, 8, 7],
#           Output: 17        [7, 1, 3],
#                             [1, 9, 5])
# Example 5 Input: @matrix = ([10, 20,  30],
#           Output: 100       [5,  5,   5],
#                             [0,  100, 0],
#                             [25, 25,  25])
#=============================================================================

use v5.42;
use List::Util qw/sum0 max/;


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

# Command line usage: give rows as comma-separated lists
my @MATRIX = map { [ split(",", $_) ] } @ARGV;
say highestRow(@MATRIX);

#=============================================================================
sub highestRow(@matrix)
{
    return max map { sum0 $_->@* } @matrix
}

sub runTest
{
    use Test2::V0;

    my @matrix;
    @matrix = ([4,  4, 4, 4], [10, 0, 0, 0], [2,  2, 2, 9]);
    is( highestRow(@matrix),  16, "Example 1");

    @matrix = ([1, 5], [7, 3], [3, 5]);
    is( highestRow(@matrix),  10, "Example 2");

    @matrix = ([1, 2, 3], [3, 2, 1]);
    is( highestRow(@matrix),   6, "Example 3");

    @matrix = ([2, 8, 7], [7, 1, 3], [1, 9, 5]);
    is( highestRow(@matrix),  17, "Example 4");

    @matrix = ([10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]);
    is( highestRow(@matrix), 100, "Example 5");

    @matrix = ([9]);
    is( highestRow(@matrix), 9, "1x1");

    @matrix = ([]);
    is( highestRow(@matrix), 0, "Empty");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
