#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge Week 196 Task 2 Range List
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# You are given a sorted unique integer array, @array.
# Write a script to find all possible Number Range i.e [x, y] represent range
# all integers from x and y (both inclusive).
# Each subsequence of two or more contiguous integers
# Example 1 Input: @array = (1,3,4,5,7)
#          Output: [3,5]
# Example 2 Input: @array = (1,2,3,6,7,9)
#          Output: [1,3], [6,7]
# Example 3 Input: @array = (0,1,2,4,5,6,8,9)
#          Output: [0,2], [4,6], [8,9]
# 
#=============================================================================

use v5.36;


use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

for my $arg ( @ARGV )
{
    $arg =~ tr/[(),/ /;
    my @array = split(' ', $arg);

    my $result = findRun(\@array);

    say join(', ', map { "[@$_]" } $result->@* );
}

sub findRun($list)
{
    my $len = scalar(@$list);
    return [[]] if $len < 2;

    my @run = ();
    my ($i, $j) = (0,1);
    while ( $i < $len )
    {
        $j = $i + 1;
        while ( $j < $len && $list->[$j] == ($list->[$j-1]+1) )
        {
            $j++;
        }
        if ( $j - $i > 1 )
        {
            push @run, [ $list->[$i], $list->[$j-1] ];
        }
        $i = $j;
    }
    return \@run;
}

sub runTest
{
    use Test2::V0;

    is( findRun( [ 1,3,4,5,7   ] ), [ [3,5] ], "Example 1");
    is( findRun( [ 1,2,3,6,7,9 ] ), [ [1,3], [6,7] ], "Example 2");
    is( findRun( [ 0,1,2,4,5,6,8,9 ] ), [ [0,2], [4,6], [8,9] ], "Example 3");

    done_testing;
}

