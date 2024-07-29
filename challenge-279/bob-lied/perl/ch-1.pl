#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 279 Task 1 Sort Letters
#=============================================================================
# You are given two arrays, @letters and @weights.
# Write a script to sort the given array @letters based on the @weights.
# Example 1 Input: @letters = ('R', 'E', 'P', 'L')
#                  @weights = (3, 2, 1, 4)
#           Output: PERL
# Example 2 Input: @letters = ('A', 'U', 'R', 'K')
#                  @weights = (2, 4, 1, 3)
#           Output: RAKU
# Example 3 Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
#                  @weights = (5, 4, 2, 6, 1, 3)
#           Output: PYTHON
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my @letters = split(//, shift);
my @weights = @ARGV;
say sortLetters(\@letters, \@weights);

sub sortLetters($letters, $weights)
{
    join '',
    map { $_->[0] }
    sort { $a->[1] <=> $b->[1] }
    map { [ $letters->[$_] => $weights->[$_] ] }
    0 .. $letters->$#*
}

sub runTest
{
    use Test2::V0;

    is( sortLetters( [qw(R E P L)],     [3,2,1,4] ),     "PERL",   "Example 1");
    is( sortLetters( [qw(A U R K)],     [2,4,1,3] ),     "RAKU",   "Example 2");
    is( sortLetters( [qw(O H Y N P T)], [5,4,2,6,1,3] ), "PYTHON", "Example 3");

    is( sortLetters( [qw(B B D E L I O)], [3,1,7,6,4,5,2] ), "BOBLIED", "Duplicate letters");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

