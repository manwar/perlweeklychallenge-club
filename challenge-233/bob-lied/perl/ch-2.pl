#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 233 Task 2 Frequency Sort 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to sort the given array in increasing order based on the
# frequency of the values. If multiple values have the same frequency then
# sort them in decreasing order.
# Example 1 Input: @ints = (1,1,2,2,2,3)
#           Ouput: (3,1,1,2,2,2)
#   '3' has a frequency of 1
#   '1' has a frequency of 2
#   '2' has a frequency of 3
# Example 2 Input: @ints = (2,3,1,3,2)
#           Ouput: (1,3,3,2,2)
#   '2' and '3' both have a frequency of 2, so they are sorted in decreasing order.
# Example 3 Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
#           Ouput: (5,-1,4,4,-6,-6,1,1,1)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(",", frequencySort(@ARGV)->@*), ")";

sub frequencySort(@list)
{
    use List::MoreUtils qw/frequency/;
    my %freq = frequency(@list);

    [ sort { $freq{$a} <=> $freq{$b} || $b <=> $a} @list ]
}

sub runTest
{
    use Test2::V0;

    is( frequencySort( 1,1,2,2,2,3 ),          [ 3,1,1,2,2,2 ], "Example 1");
    is( frequencySort( 2,3,1,3,2   ),          [ 1,3,3,2,2   ], "Example 2");
    is( frequencySort( -1,1,-6,4,5,-6,1,4,1 ), [ 5,-1,4,4,-6,-6,1,1,1 ], "Example 3");

    done_testing;
}
