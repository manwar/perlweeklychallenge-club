#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 226 Task 1 Shuffle String 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a string and an array of indices of same length as string.
# Write a script to return the string after re-arranging the indices in the
# correct order.
# Example 1 Input: $string = 'lacelengh', @indices = (3,2,0,5,4,8,6,7,1)
#           Output: 'challenge'
# Example 2 Input: $string = 'rulepark', @indices = (4,7,3,1,0,5,2,6)
#           Output: 'perlraku'
#
##########
# The mapping provided by the array of indices is that for each index i in
# @indices, the output at position i comes from input[ $indices[i] ].
# In example one, the 3 at position 0 means that the 0th position of the
# output comes from the 3rd position of the input (i.e, the first 'l' in
# 'challenge' [3] comes from the first 'l' in 'lacelengh' [0]).
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub shuffleString($str, @indices)
{
    my @result;

    # Literal mapping of indices in a loop
    # my @s = split(//, $str);
    # while ( my ($inIndex, $outIndex) = each @indices )
    # {
    #     $result[$outIndex] = $s[$inIndex]
    # }

    # Shorter, using array slice
    @result[@indices] = split(//, $str);

    return join("", @result);
}

sub runTest
{
    use Test2::V0;

    is( shuffleString("lacelengh", 3,2,0,5,4,8,6,7,1 ), 'challenge', "Example 1");
    is( shuffleString("rulepark",  4,7,3,1,0,5,2,6 ),   'perlraku',  "Example 2");

    done_testing;
}

