#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 281 Task 1 Check Color
#=============================================================================
# You are given coordinates, a string that represents the coordinates of
# a square of the chessboard as shown below:
# Write a script to return true if the square is light, and false if
# the square is dark.
# Example 1 Input: $coordinates = "d3" Output: true
# Example 2 Input: $coordinates = "g5" Output: false
# Example 3 Input: $coordinates = "e6" Output: true
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my %Board = (
    a => [ undef, false, true, false, true, false, true, false, true ],
    b => [ undef, true, false, true, false, true, false, true, false ],
    c => [ undef, false, true, false, true, false, true, false, true ],
    d => [ undef, true, false, true, false, true, false, true, false ],
    e => [ undef, false, true, false, true, false, true, false, true ],
    f => [ undef, true, false, true, false, true, false, true, false ],
    g => [ undef, false, true, false, true, false, true, false, true ],
    h => [ undef, true, false, true, false, true, false, true, false ],
);

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say checkColor($_) for @ARGV;

sub checkColor($s)
{
    return $Board{substr($s,0,1)}[substr($s,1)];
}

sub runTest
{
    use Test2::V0;

    is( checkColor("d3"), true,  "Example 1");
    is( checkColor("g5"), false, "Example 2");
    is( checkColor("e6"), true,  "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
