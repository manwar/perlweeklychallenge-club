#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 318 Task 2 Reverse Equals
#=============================================================================
# You are given two arrays of integers, each containing the same elements
# as the other.  Write a script to return true if one array can be made to
# equal the other by reversing exactly one contiguous subarray.
# Example 1 Input: @source = (3, 2, 1, 4); @target = (1, 2, 3, 4)
#           Output: true
#   Reverse elements: 0-2
#
# Example 2 Input: @source = (1, 3, 4); @target = (4, 1, 3)
#           Output: false
#
# Example 3 Input: @source = (2); @target = (2)
#           Output: true
#=============================================================================

use v5.40;

use Getopt::Long;
my $DoTest  = false;

GetOptions("test" => \$DoTest);
#=============================================================================

exit(!runTest()) if $DoTest;

# Command line usage: two lists given as strings,
# Example: perl ch-2.pl "1 2 3 4" "1 3 2 4"

say revEq( [split(/[\D]/, $ARGV[0])], [split(/[\D]/, $ARGV[1])]) ? "true" : "false";

#=============================================================================
sub revEq ($source, $target)
{
    use List::Util qw/zip/;
    use List::MoreUtils qw/first_index last_index/;

    # Arrays must be the same size
    return false if $source->$#* != $target->$#*;

    # Combine the two arrays into pairs
    my @pair = zip($source, $target);

    # Find the left segment of equal elements
    my $left = first_index { $_->[0] != $_->[1] } @pair;

    # If strings are equal, we can stop
    return true if $left == -1;

    # Find the right segment of equal elements
    my $right = last_index { $_->[0] != $_->[1] } @pair;

    # Extract the middle that could be reversed.
    my @midsrc = $source->@[$left .. $right];
    my @midtrg = $target->@[$left .. $right];

    # Check that one is the reverse of the other
    while ( @midsrc  &&  shift @midsrc == pop @midtrg ) {}
    return @midsrc == 0;
}

sub runTest
{
    use Test2::V0;

    is( revEq([3,2,1,4], [1,2,3,4]),  true, "Example 1");
    is( revEq([1,3,4  ], [4,1,3  ]), false, "Example 2");
    is( revEq([2      ], [2      ]),  true, "Example 3");

    is( revEq([2,3,4,1], [2,3,4,1]),  true, "Equal arrays");
    is( revEq([       ], [       ]),  true, "Empty arrays");
    is( revEq([2,1,4,3], [2,3,4,1]),  true, "Right side");
    is( revEq([2,1,4,3], [2,4,1,3]),  true, "Middle");

    done_testing;
}
