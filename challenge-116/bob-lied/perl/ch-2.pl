#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 116 Task #2 Sum Of Squares 
# You are given a number $N >= 10.
# Write a script to find out if the given number $N is such that sum of
# squares of all digits is a perfect square. Print 1 if it is otherwise 0.
# Example
# Input: $N = 34 Output: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
# Input: $N = 50 Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
# Input: $N = 52 Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
# 
#=============================================================================

use strict;
use warnings;
use v5.30;

use experimental qw/ signatures /;
no warnings "experimental::signatures";


use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);

my $N = shift;
die usage() unless defined $N && $N >= 10;

exit(!runTest()) if $DoTest;

sub sumOfSquares($N)
{
    my @digit = split(//, $N);

    my @square = map { $_ * $_ } @digit;

    my $sum = 0;
    $sum += $_ foreach @square;

    my $root = sqrt($sum);

    say "(@square) = > $sum => $root" if ( $Verbose );

    return ( $root == int($root) ? 1 : 0 );
}

sub runTest
{
    use Test::More;

    is(sumOfSquares(34), 1, "N=34");
    is(sumOfSquares(50), 1, "N=34");
    is(sumOfSquares(52), 0, "N=52");

    done_testing;
}

