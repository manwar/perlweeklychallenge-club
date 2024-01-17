#!/usr/bin/env perl

# Challenge 249
#
# Task 1: Equal Pairs
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers with even number of elements.
#
# Write a script to divide the given array into equal pairs such that:
#
# a) Each element belongs to exactly one pair.
# b) The elements present in a pair are equal.
#
#
# Example 1
#
# Input: @ints = (3, 2, 3, 2, 2, 2)
# Output: (2, 2), (3, 3), (2, 2)
#
# There are 6 elements in @ints.
# They should be divided into 6 / 2 = 3 pairs.
# @ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the conditions.
#
# Example 2
#
# Input: @ints = (1, 2, 3, 4)
# Output: ()
#
# There is no way to divide @ints 2 pairs such that the pairs satisfy every condition.

use Modern::Perl;

my @pairs = make_pairs(@ARGV);
print_pairs(@pairs);

sub make_pairs {
    my(@ints) = @_;
    my @pairs;
    if (@ints == 0 || (@ints % 2) == 1) {
        return ();
    }
pair:
    while (@ints) {
        my $a = 0;
        for my $b (1 .. $#ints) {
            if ($ints[$a] == $ints[$b]) {
                push @pairs, [$ints[$a], $ints[$b]];
                splice @ints, $b, 1;
                shift @ints;
                next pair;
            }
        }
        return ();
    }
    return @pairs;
}

sub print_pairs {
    my(@pairs) = @_;
    if (@pairs) {
        say join ", ", map {"(".$_->[0].", ".$_->[1].")"} @pairs;
    }
    else {
        say "()";
    }

}
