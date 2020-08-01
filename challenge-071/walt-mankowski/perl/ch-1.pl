#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.32);
use experimental qw(signatures);
use List::Util qw(shuffle);

# TASK #1 › Peak Element
# Submitted by: Mohammad S Anwar
#
# You are given positive integer $N (>1).
#
# Write a script to create an array of size $N with random unique
# elements between 1 and 50.
#
# In the end it should print peak elements in the array, if found.
#
#     An array element is called peak if it is bigger than it’s
#     neighbour.
#
# Example 1
# Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
# Peak: [ 48, 45, 21 ]
# Example 2
# Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
# Peak: [ 47, 32, 39, 36 ]

my $N = shift @ARGV;

my @a = make_array($N);
my @p = peaks(@a);

$" = ", ";
say "Array: [@a[1..$#a-1]]";
say "Peak:  [@p]";

sub make_array($N) {
    my @a = shuffle 1..50;
    return (0, @a[0..$N-1], 0);
}

sub peaks(@a) {
    my @p;
    for my $i (1..$#a-1) {
        push @p, $a[$i] if $a[$i-1] < $a[$i] > $a[$i+1];
    }

    return @p;
}
