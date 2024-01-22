#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 253 Task 2 Weakest Row
#=============================================================================
# You are given an m x n binary matrix, i.e. only 0 and 1,
# where 1 always appear before 0.
# A row i is weaker than a row j if one of the following is true:
#  a) The number of 1s in row i is less than the number of 1s in row j.
#  b) Both rows have the same number of 1 and i < j.
# Write a script to return the order of rows from weakest to strongest.
# Example 1 Input: $matrix = [ [1, 1, 0, 0, 0],
#                              [1, 1, 1, 1, 0],
#                              [1, 0, 0, 0, 0],
#                              [1, 1, 0, 0, 0],
#                              [1, 1, 1, 1, 1] ]
#       Output: (2, 0, 3, 1, 4)
# Example 2 Input: $matrix = [ [1, 0, 0, 0],
#                              [1, 1, 1, 1],
#                              [1, 0, 0, 0],
#                              [1, 0, 0, 0] ]
#       Output: (0, 2, 3, 1)
#=============================================================================

use v5.38;

use builtin qw/trim/; no warnings "experimental::builtin";
use List::Util qw/sum/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# USAGE: give rows as strings on command line, e.g.
# ./ch-1.pl "[1,0,0]" "[0,1,0]" "[0,0,1]"
# ./ch-1.pl 1,0,0 0,1,0 0,0,1
my @r = map { trim($_) } map { (s/[^01]+/ /gr) } @ARGV;
say join "|", @r if $Verbose;
my @matrix = map { [ split ' ', $_ ] } @r;
say "(", join(", ", weakestRow(\@matrix)->@*), ")";

sub weakestRow($m)
{
    my @strength = map { sum $_->@* } $m->@*;

    return [ sort { $strength[$a] <=> $strength[$b] || $a <=> $b } 0 .. $m->$#* ];
}

sub runTest
{
    use Test2::V0;

    my $matrix;
    $matrix = [ [1, 1, 0, 0, 0],
                [1, 1, 1, 1, 0],
                [1, 0, 0, 0, 0],
                [1, 1, 0, 0, 0],
                [1, 1, 1, 1, 1] ];
    is(weakestRow($matrix), [ 2,0,3,1,4 ], "Example 1");

    $matrix = [ [1, 0, 0, 0],
                [1, 1, 1, 1],
                [1, 0, 0, 0],
                [1, 0, 0, 0] ];
    is(weakestRow($matrix), [   0,2,3,1 ], "Example 2");

    done_testing;
}
