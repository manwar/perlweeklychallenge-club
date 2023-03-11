#!/usr/bin/perl

# Challenge 200
#
# Task 1: Arithmetic Slices
# Submitted by: Mohammad S Anwar
# You are given an array of integers.
#
# Write a script to find out all Arithmetic Slices for the given array of integers.
#
# An integer array is called arithmetic if it has at least 3 elements and the
# differences between any three consecutive elements are the same.
#
#
# Example 1
# Input: @array = (1,2,3,4)
# Output: (1,2,3), (2,3,4), (1,2,3,4)
# Example 2
# Input: @array = (2)
# Output: () as no slice found.

use Modern::Perl;

sub is_arithmetic {
    my(@in) = @_;
    return 0 if @in < 3;
    my $step = $in[1]-$in[0];
    for my $i (2..$#in) {
        return 0 if $in[$i]-$in[$i-1] != $step;
    }
    return 1;
}

sub slices {
    my(@nums) = @_;
    my @out;
    for my $i (0 .. $#nums-2) {
        for my $j ($i+2 .. $#nums) {
            my @slice = @nums[$i..$j];
            if (is_arithmetic(@slice)) {
                push @out, \@slice;
            }
        }
    }
    return @out;
}

my @in = @ARGV;
my @out = slices(@in);
if (!@out) {
    say "()";
}
else {
    say join(", ", map {"(".join(",", @$_).")"} @out);
}
