#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 300 Task 1 Beautiful Arrangement
#=============================================================================
# You are given a positive integer, $int.
# Write a script to return the number of beautiful arrangements that you
# can construct.  A permutation of n integers, 1-indexed, is considered
# a beautiful arrangement if, for every i (1 <= i <= n), either of the
# following is true:
#   1) perm[i] is divisible by i
#   2) i is divisible by perm[i]
#
# Example 1 Input: $n = 2 Output: 2
#   1st arrangement: [1, 2]
#   perm[1] is divisible by i = 1
#   perm[2] is divisible by i = 2
#   2nd arrangement: [2, 1]
#   perm[1] is divisible by i = 1
#   i=2 is divisible by perm[2] = 1
#
# Example 2 Input: $n = 1 Output: 1
# Example 3 Input: $n = 10 Output: 700
#=============================================================================

use v5.40;

use Algorithm::Permute;
use List::Util qw/all/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say beauty($_) for @ARGV;

sub beauty($n)
{
    my $count = 0;
    my $p = Algorithm::Permute->new([reverse 1..$n]);
    while ( my @res = $p->next )
    {
        unshift @res, 0;
        $count++ if all { $_ % $res[$_] == 0 || $res[$_] % $_ == 0 } 1 .. $#res
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( beauty( 2),   2, "Example 1");
    is( beauty( 1),   1, "Example 2");
    is( beauty(10), 700, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
