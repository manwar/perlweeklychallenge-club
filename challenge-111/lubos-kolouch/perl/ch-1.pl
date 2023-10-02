#!/usr/bin/perl
use strict;
use warnings;

sub search_matrix {
    my ($matrix, $target) = @_;
    my $rows = scalar @$matrix;
    my $cols = scalar @{$matrix->[0]};

    my ($left, $right) = (0, $rows * $cols - 1);

    while ($left <= $right) {
        my $mid = int(($left + $right) / 2);
        my $mid_value = $matrix->[$mid / $cols][$mid % $cols];

        if ($mid_value == $target) {
            return 1;
        } elsif ($mid_value < $target) {
            $left = $mid + 1;
        } else {
            $right = $mid - 1;
        }
    }
    return 0;
}

# Test cases:
my $matrix = [
    [1, 2, 3, 5, 7],
    [9, 11, 15, 19, 20],
    [23, 24, 25, 29, 31],
    [32, 33, 39, 40, 42],
    [45, 47, 48, 49, 50]
];

print search_matrix($matrix, 35), "\n";  # Output: 0
print search_matrix($matrix, 39), "\n";  # Output: 1

