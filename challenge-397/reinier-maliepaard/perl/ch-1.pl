#!/usr/bin/perl
use strict;
use warnings;

use POSIX qw(ceil); # Round up to the next integer.

sub missing_positive_above_average {
    my (@a) = @_;

    die "Error: array must not be empty\n" unless @a;

    # Check that every element is an integer.
    die "Error: all elements must be integers\n"
        if grep { !defined($_) || !/\A[+-]?\d+\z/ } @a;

    my %f;
    my $sum = 0;

    # Calculate the sum and record which values occur.
    ( $sum += $_, $f{$_} = 1 ) for @a;

    my $average = $sum / scalar @a;
    my $candidate = ceil($average);

    # Find an integer that is positive and strictly above the average.
    $candidate++ while $candidate <= 0 || $candidate <= $average;

    # Skip integers that already occur in the array.
    $candidate++ while $f{$candidate};

    return $candidate;
}

# Tests

my @a;

# Example 1
@a = (1, 2, 4, 5, 6);
print missing_positive_above_average(@a), "\n"; #  Output: 7

# Example 2
@a = (-5, -2, -1, 3);
print missing_positive_above_average(@a), "\n"; # Output: 1

# Example 3
@a = (1, 2, 3);
print missing_positive_above_average(@a), "\n"; # Output: 4

# Example 4
@a = (2, 3, 7, 8);
print missing_positive_above_average(@a), "\n"; # Output: 6

# Example 5
@a = (1, 1, 1, 10);
print missing_positive_above_average(@a), "\n"; # Output: 4
