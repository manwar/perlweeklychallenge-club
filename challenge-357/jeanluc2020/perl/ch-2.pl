#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK2
#
# Task 2: Unique Fraction Generator
# =================================
#
# Given a positive integer N, generate all unique fractions you can create using integers from 1 to N and follow the rules below:
#
# - Use numbers 1 through N only (no zero)
# - Create fractions like numerator/denominator
# - List them in ascending order (from smallest to largest)
# - If two fractions have the same value (like 1/2 and 2/4),
#   only show the one with the smallest numerator
#
# Example 1
#
# Input: $int = 3
# Output: 1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1
#
# Example 2
#
# Input: $int = 4
# Output: 1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1
#
#
# Example 3
#
# Input: $int = 1
# Output: 1/1
#
#
# Example 4
#
# Input: $int = 6
# Output: 1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4,
#         4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1,
#         5/2, 3/1, 4/1, 5/1, 6/1
#
#
# Example 5
#
# Input: $int = 5
# Output: 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1,
#         5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible fractions and add them to an array, unless
# the fraction can be reduced. In order to determine whether a
# fraction can be reduced, we calculate the greatest common
# divisor of the two numbers via Euclid's algorithm and check
# whether or not it is equal to 1.
# By storing each fraction as a tuple (modelled as an array of two
# values) of its value and the fraction as a string, we can easily
# sort by the value and later print the string representation.
#

use v5.36;

unique_fraction_generator(3);
unique_fraction_generator(4);
unique_fraction_generator(1);
unique_fraction_generator(6);
unique_fraction_generator(5);

sub unique_fraction_generator($int) {
    say "Input: $int";
    my @result = ();
    foreach my $i (1..$int) {
        foreach my $j (1..$int) {
            push @result, [$i/$j, "$i/$j"] unless can_be_reduced($i, $j);
        }
    }
    say "Output: " . join(", ", map { $_->[1] } sort { $a->[0] <=> $b->[0] } @result);
}

sub can_be_reduced($i, $j) {
    while($j != 0) {
        if($i > $j) {
            $i = $i - $j;
        } else {
            $j = $j - $i;
        }
    }
    return $i > 1;
}
