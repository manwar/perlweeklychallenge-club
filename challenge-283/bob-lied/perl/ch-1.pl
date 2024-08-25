#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 283 Task 1 Unique Number
#=============================================================================
# You are given an array of integers, @ints, where every element
# appears more than once except one element.
# Write a script to find the one element that appears exactly one time.
# Example 1 Input: @ints = (3, 3, 1)          Output: 1
# Example 2 Input: @ints = (3, 2, 4, 2, 4)    Output: 3
# Example 3 Input: @ints = (1)                Output: 1
# Example 4 Input: @ints = (4, 3, 1, 1, 1, 4) Output: 3
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say uniqNum(@ARGV) // "none";

sub uniqNum(@ints)
{
    my %appear;
    $appear{$_}++ for @ints;
    my @candidate = grep { $appear{$_} == 1 } keys %appear;
    if    ( @candidate  > 1 ) { return "multiple"; }
    elsif ( @candidate == 1 ) { return $candidate[0]; }
    else                      { return "none"; }
}

sub un2(@ints)
{
    use List::MoreUtils qw/singleton/;
    my @candidate = singleton(@ints);
    if    ( @candidate  > 1 ) { return "multiple"; }
    elsif ( @candidate == 1 ) { return $candidate[0]; }
    else                      { return "none"; }
}

sub runTest
{
    use Test2::V0;

    is( uniqNum(3, 3, 1), 1,          "Example 1");
    is( uniqNum(3, 2, 4, 2, 4), 3,    "Example 2");
    is( uniqNum(1), 1,                "Example 3");
    is( uniqNum(4, 3, 1, 1, 1, 4), 3, "Example 4");
    is( uniqNum(1, 2, 3), "multiple", "Multiple unique numbers");
    is( uniqNum(8, 8, 8), "none",     "No unique numbers");
    is( uniqNum(       ), "none",     "Empty list");

    is( un2(3, 3, 1), 1,          "Example 1");
    is( un2(3, 2, 4, 2, 4), 3,    "Example 2");
    is( un2(1), 1,                "Example 3");
    is( un2(4, 3, 1, 1, 1, 4), 3, "Example 4");
    is( un2(1, 2, 3), "multiple", "Multiple unique numbers");
    is( un2(8, 8, 8), "none",     "No unique numbers");
    is( un2(       ), "none",     "Empty list");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @ints = ( (1..100), (1..99) );

    cmpthese($repeat, {
            hash => sub { uniqNum(@ints) },
            util => sub { un2(@ints) },
        });
}
