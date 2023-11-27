#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 172 Task 1 Prime Partition 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two positive integers, $m and $n.
# Write a script to find out the Prime Partition of the given number.
# No duplicates allowed.
# Example 1 Input: $m = 18, $n = 2
#           Output: 5, 13 or 7, 11
# Example 2 Input: $m = 19, $n = 3
#           Output: 3, 5, 11
#####
# A prime partition is a set of primes that sums to the target number.
# There is a function in Math::Prime::Util that does this.
#=============================================================================
# https://en.wikipedia.org/wiki/Partition_(number_theory)
# Example 1: Input: $m = 18, $n = 2
#           Output: 5, 13 or 7, 11
# Example 2: Input: $m = 19, $n = 3
#           Output: 3, 5, 11
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $M = shift;
my $N = shift;

die "Usage: $0 m n" unless $M && $N;
die "n must be <= m/2" unless $N <= $M/2;
my $answer = primePartition($M, $N);
if ( $Verbose )
{
    say join(" or ", map { join(", ", $_->@*) } $answer->@*);
}
else
{
    say "$_->@*" for $answer->@*;
}

sub noDup(@list)
{
    use List::Util qw/uniqint/;
    return scalar(uniqint(@list)) == scalar(@list);
}

sub primePartition($m, $n)
{
    use Math::Prime::Util qw/forpart/;
    my @part;
    forpart { push @part, [ @_ ] if noDup(@_) } $m, { n => $n, prime => 1} ;

    return \@part;
}

sub runTest
{
    use Test2::V0;
    use builtin qw/true false/; no warnings "experimental::builtin";

    is( noDup(1,2,3,4), true,  "noDup true");
    is( noDup(1,1,3,4), false, "noDup false begin");
    is( noDup(1,2,2,4), false, "noDup false middle");
    is( noDup(1,2,4,4), false, "noDup false end");

    is( primePartition(18, 2), [ [5,13], [7,11] ], "Example 1");
    is( primePartition(19, 3), [ [3,5,11]       ], "Example 2");

    done_testing;
}
