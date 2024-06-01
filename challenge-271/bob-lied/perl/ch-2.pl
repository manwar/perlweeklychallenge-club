#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 271 Task 2 Sort by 1 Bits
#=============================================================================
# You are give an array of integers, @ints.
# Write a script to sort the integers in ascending order by the number
# of 1 bits in their binary representation. In case more than one integers
# have the same number of 1 bits then sort them in ascending order.
# Example 1 Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
#           Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)
# Example 2 Input: @ints = (1024, 512, 256, 128, 64)
#           Output: (64, 128, 256, 512, 1024)
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", sortBy1Bits(@ARGV)->@*), ")";

sub sortBy1Bits(@ints)
{
    my @bits = map { (my $b = sprintf("%b", $ints[$_])) =~ tr/1/1/ } 0 .. $#ints;
    return [ @ints[ sort { $bits[$a] <=> $bits[$b] || $ints[$a] <=> $ints[$b] } 0 .. $#ints ] ];
}

sub runTest
{
    use Test2::V0;

    is( sortBy1Bits(0, 1, 2, 3, 4, 5, 6, 7, 8), [ 0,1,2,4,8,3,5,6,7 ], "Example 1");
    is( sortBy1Bits(1024, 512, 256, 128, 64  ), [64,128,256,512,1024], "Example 2");

    done_testing;
}
