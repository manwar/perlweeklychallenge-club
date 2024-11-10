#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 294 Task 1 Consecutive Sequence
#=============================================================================
# You are given an unsorted array of integers, @ints.
# Write a script to return the length of the longest consecutive elements
# sequence. Return -1 if none found. The algorithm must runs in O(n) time.
# Example 1 Input: @ints = (10, 4, 20, 1, 3, 2)
#           Output: 4
#   The longest consecutive sequence (1, 2, 3, 4).
# Example 2 Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
#           Output: 9
# Example 3 Input: @ints = (10, 30, 20)
#           Output: -1
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say consecutive(@ARGV);

sub consecutive(@ints)
{
    my %int = map { $_ => $_ } @ints;
    my $maxLen = 0;

    while ( defined(my $n = shift @ints) )
    {
        if ( ! exists( $int{$n-1} ) )
        {
            # $n is the start of a possible sequence
            my $len = 1;
            $len++ while ( exists( $int{++$n} ) );
            $maxLen = $len if $len > $maxLen;
        }
    }
    return $maxLen > 1 ? $maxLen : -1;
}

sub runTest
{
    use Test2::V0;

    is( consecutive(10, 4,20, 1, 3, 2),             4, "Example 1");
    is( consecutive( 0, 6, 1, 8, 5, 2, 4, 3, 0, 7), 9, "Example 2");
    is( consecutive(10,20,30),                     -1, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
