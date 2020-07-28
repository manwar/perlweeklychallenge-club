#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 71 
#=============================================================================
# 
# TASK #1 > Peak Element
# 
# You are given positive integer $N (>1).
#
# Write a script to create an array of size $N with random unique elements
# between 1 and 50.
#
# In the end it should print peak elements in the array, if found.
#
#    An array element is called peak if it is bigger than its neighbour.
#
# Example 1
#  Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
#  Peak: [ 48, 45, 21 ]
#
# Example 2
#  Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
#  Peak: [ 47, 32, 39, 36 ]

use strict;
use warnings;
use feature qw(say);

use Test::More;

my ($MinVal, $MaxVal) = (1, 50);

sub isPeak
{
    my ($prev, $me, $next) = @_;
    return ($prev < $me) && ($me > $next);
}

sub peakElement
{
    my @arr = ($MinVal-1, @_, $MinVal-1);
    my @peak = ();
    my $last = $#arr - 1;

    foreach ( 1..$last )
    {
        if ( isPeak($arr[$_-1], $arr[$_], $arr[$_+1] ) )
        {
            push @peak, $arr[$_]
        }
    }

    return \@peak;
}

is_deeply(peakElement(2, 1 ),         [2],    "two elements, left");
is_deeply(peakElement(1, 2 ),         [2],    "two elements, right");
is_deeply(peakElement(6, 4, 2 ),      [6],    "three elements, first");
is_deeply(peakElement(6, 8, 2 ),      [8],    "three elements, middle");
is_deeply(peakElement(6, 7, 9 ),      [9],    "three elements, last");
is_deeply(peakElement(8, 5, 9 ),      [8,9],  "three elements, both ends");
is_deeply(peakElement(1, 3, 5, 4),    [5],    "even # elements, middle peak ");
is_deeply(peakElement(9, 3, 5, 8),    [9, 8], "even # elements, both ends ");
is_deeply(peakElement(9, 3, 4, 5, 8), [9, 8], "odd # elements, both ends ");
is_deeply(peakElement(3, 9, 4, 8, 5), [9, 8], "odd # elements, middle peaks");

is_deeply(peakElement(18, 45, 38, 25, 10, 7, 21, 6, 28, 48), [45, 21, 48], "example 1");
is_deeply(peakElement(47, 11, 32, 8, 1, 9, 39, 14, 36, 23), [47, 32, 39, 36], "example 2");

done_testing();
