#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 201 Task 1 Missing Numbers
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of unique numbers.
# Write a script to find out all missing numbers in the range 0..$n
# where $n is the array size.
# Example 1 Input: @array = (0,1,3) Output: 2
#   The array size i.e. total element count is 3, so the range is 0..3.
#   The missing number is 2 in the given array.
# Example 2 Input: @array = (0,1) Output: 2
#   The array size is 2, therefore the range is 0..2.
#   The missing number is 2.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Take anything that looks list-ish as arguments, squash it together
# and remove punctuation.  What's left should be a string of numbers.
# Split that string on white space to get a list of numbers. This
# is too rough -- it distorts negative numbers and decimal points, but
# good enough for the examples and some quick tests.
my $list = "@ARGV";
$list =~ s/[[:punct:]]/ /g;

say join(' ', missingNumber( [ split(' ', $list) ] )->@* );

sub missingNumber($list)
{
    # Make a hash where the keys are numbers 0 .. n.  Start out assuming
    # that every number is missing.  Note that $# works on references.
    my $n = 1 + $#{$list};
    my %missing = map { $_ => 1 } 0 .. $n;

    # The ones in the list are not missing. Numbers that are out
    # of range would be silently ignored in delete, but just to be
    # explicit, let's only delete things that actually exist.
    # This convenient syntax of 0<x<n is a feature of Perl 5.32.
    delete $missing{$_} for grep { 0 <= $_ <= $n } $list->@*;

    # Sort isn't actually required.
    return [ sort { $a <=> $b } keys %missing ];
}

sub runTest
{
    use Test2::V0;

    is( missingNumber( [ 0,1,3   ] ), [ 2 ], "Example 1");
    is( missingNumber( [ 0,1     ] ), [ 2 ], "Example 2");

    is( missingNumber( [ 2,3     ] ), [ 0,1   ], "Missing head");
    is( missingNumber( [ 0,1,9   ] ), [ 2,3   ], "Missing tail");
    is( missingNumber( [ 0,5,3,1 ] ), [ 2,4   ], "Missing multiple");
    is( missingNumber( [ 8,9     ] ), [ 0,1,2 ], "Missing whole range");
    is( missingNumber( [ 3,-1    ] ), [ 0,1,2 ], "Missing negative");

    done_testing;
}

