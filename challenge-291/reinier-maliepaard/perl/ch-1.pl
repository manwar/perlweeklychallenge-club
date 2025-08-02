#!/usr/bin/perl
use strict;
use warnings;

sub middle_index {
    my $total = 0;
    $total += $_ for @_;

    my $left_sum = 0;
    for my $index (0 .. @_ - 1) {
        return ($index) if ($left_sum == $total - $left_sum - $_[$index]);
        $left_sum += $_[$index];
    }

    return (-1);
}

# Tests

my @ints;

# Example 1
@ints = (2, 3, -1, 8, 4);
print(middle_index(@ints), "\n"); # Output: 3

# Example 2
@ints = (1, -1, 4);
print(middle_index(@ints), "\n"); # Output: 2

# Example 3
@ints = (2, 5);
print(middle_index(@ints), "\n"); # Output: -1"

