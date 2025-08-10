#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 333 Task 1  Straight Line
#=============================================================================
# You are given a list of co-ordinates. Write a script to find out if the
# given points make a straight line.
# Example 1 Input: @list = ([2, 1], [2, 3], [2, 5])
#           Output: true
# Example 2 Input: @list = ([1, 4], [3, 4], [10, 4])
#           Output: true
# Example 3 Input: @list = ([0, 0], [1, 1], [2, 3])
#           Output: false
# Example 4 Input: @list = ([1, 1], [1, 1], [1, 1])
#           Output: true
# Example 5 Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
#           Output: true
#=============================================================================

use v5.42;


use Getopt::Long;
my $DoTest  = false;

GetOptions("test" => \$DoTest);
#=============================================================================

exit(!runTest()) if $DoTest;

# Use as ch-1.pl 1,1 2,2  3,3

my @point = map {  [split ',', $_] } @ARGV;
die "Need three points" unless @point == 3;

say isLine(@point) ? "true" : "false";

#=============================================================================
## https://math.stackexchange.com/questions/701862/how-to-find-if-the-points-fall-in-a-straight-line-or-not
sub isLine(@point)
{
    my @x = map { $_->[0] } @point;
    my @y = map { $_->[1] } @point;

    return ($y[1] - $y[0]) * ( $x[2] - $x[0] )  == ( $y[2] - $y[0] ) * ( $x[1] - $x[0] )
}

sub runTest
{
    use Test2::V0;

    is( isLine( [2,1],[2,3],[ 2,5] ),  true, "Example 1");
    is( isLine( [1,4],[3,4],[10,4] ),  true, "Example 2");
    is( isLine( [0,0],[1,1],[ 2,3] ), false, "Example 3");
    is( isLine( [1,1],[1,1],[ 1,1] ),  true, "Example 4");
    is( isLine( [1000000, 1000000], [2000000, 2000000], [3000000, 3000000] ), true, "Example 5");

    done_testing;
}
