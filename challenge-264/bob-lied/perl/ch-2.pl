#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 264 Task 2 Target Array
#=============================================================================
# You are given two arrays of integers, @source and @indices.
# The @indices can only contains integers 0 <= i < size of @source.
# Write a script to create target array by insert at index $indices[i]
# the value $source[i].
# Example 1 Input: @source  = (0, 1, 2, 3, 4)
#                  @indices = (0, 1, 2, 2, 1)
#           Output: (0, 4, 1, 3, 2)
#   @source  @indices  @target
#   0        0         (0)
#   1        1         (0, 1)
#   2        2         (0, 1, 2)
#   3        2         (0, 1, 3, 2)
#   4        1         (0, 4, 1, 3, 2)
#
# Example 2 Input: @source  = (1, 2, 3, 4, 0)
#                  @indices = (0, 1, 2, 3, 0)
#           Output: (0, 1, 2, 3, 4)
#   @source  @indices  @target
#   1        0         (1)
#   2        1         (1, 2)
#   3        2         (1, 2, 3)
#   4        3         (1, 2, 3, 4)
#   0        0         (0, 1, 2, 3, 4)
#
# Example 3 Input: @source  = (1)
#                  @indices = (0)
#           Output: (1)
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub targArr($source, $indices)
{
    my @target = ();
    for my $i ( 0 .. $indices->$#* )
    {
        splice(@target, $indices->[$i], 0, $source->[$i]);
        say "$i\t$source->[$i]\t$indices->[$i],(@target)" if $Verbose;
    }
    return \@target;
}

sub runTest
{
    use Test2::V0;

    is( targArr([0,1,2,3,4],[0,1,2,2,1]), [0,4,1,3,2], "Example 1");

    is( targArr([1,2,3,4,0],[0,1,2,3,0]), [0,1,2,3,4], "Example 2");

    is( targArr([1],[0]), [1], "Example 3");

    done_testing;
}
