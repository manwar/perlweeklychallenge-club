#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 282 Task 1 Good Integer
#=============================================================================
# You are given a positive integer, $int, having 3 or more digits.
# Write a script to return the Good Integer in the given integer or -1
# if none found.  A good integer is exactly three consecutive matching digits.
# Example 1 Input: $int = 12344456 Output: "444"
# Example 2 Input: $int = 1233334  Output: -1
# Example 3 Input: $int = 10020003 Output: "000"
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say goodIint($_) for @ARGV;

sub goodInt($int)
{
    my @digit = split(//, "$int");
    my $d = shift @digit;
    while ( defined $d  )
    {
        my $consecutive = 1;
        my $n;
        ++$consecutive while defined($n = shift @digit) && $n == $d;
        return ($d x 3) if $consecutive == 3;
        $d = $n;
    }
    return -1;
}

sub runTest
{
    use Test2::V0;

    is( goodInt(12344456), "444", "Example 1");
    is( goodInt(1233334),     -1, "Example 2");
    is( goodInt(10020003), "000", "Example 3");
    is( goodInt(66612345), "666", "At front");
    is( goodInt(12345666), "666", "At end");
    is( goodInt(17775666), "777", "Two possibilities");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
