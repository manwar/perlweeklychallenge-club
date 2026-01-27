#!/usr/bin/env perl

# Challenge 301
#
# Task 1: Largest Number
# Submitted by: Mohammad Sajid Anwar
# You are given a list of positive integers, @ints.
#
# Write a script to arrange all the elements in the given list such that they form the largest number and return it.
#
# Example 1
# Input: @ints = (20, 3)
# Output: 320
# Example 2
# Input: @ints = (3, 30, 34, 5, 9)
# Output: 9534330

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say largest_num(@ARGV);

sub largest_num {
    my(@nums) = @_;
    my $largest = 0;

    my $find_largest;
    $find_largest = sub {
        my($prefix, $pending) = @_;
        if (@$pending == 0) {
            my $num = 0+$prefix;
            $largest = $num if $largest < $num;
        }
        else {
            for my $i (0 .. $#$pending) {
                my $new_prefix = $prefix . $pending->[$i];
                my @new_pending = @$pending;
                splice(@new_pending, $i, 1);
                $find_largest->($new_prefix, \@new_pending);
            }
        }
    };

    $find_largest->("", \@nums);
    return $largest;
}
