#!/usr/bin/env perl

# Challenge 071
#
# TASK #1 › Peak Element
# Submitted by: Mohammad S Anwar
# You are given positive integer $N (>1).
#
# Write a script to create an array of size $N with random unique elements
# between 1 and 50.
#
# In the end it should print peak elements in the array, if found.
#
# An array element is called peak if it is bigger than it’s neighbour.
#
# Example 1
# Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
# Peak: [ 48, 45, 21 ]
# Example 2
# Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
# Peak: [ 47, 32, 39, 36 ]

use Modern::Perl;

my @n = @ARGV;
say join(", ", peek_elem(@n));

sub peek_elem {
    my(@n) = @_;
    my @out;
    return @out if @n<2;
    if ($n[0]>$n[1]) {
        push @out, $n[0];
    }
    for my $i (1 .. @n-2) {
        if ($n[$i]>$n[$i-1] && $n[$i]>$n[$i+1]) {
            push @out, $n[$i];
        }
    }
    if ($n[-1]>$n[-2]) {
        push @out, $n[-1];
    }
    return @out;
}
