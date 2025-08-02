#!/usr/bin/perl
use strict;
use warnings;

sub weakest_row {
    my ($matrix) = @_;

    # Count the number of 1s in each row and keep track of the row index
    my @row_strength = map { [scalar(grep { $_ == 1 } @{$matrix->[$_]}), $_] } 0..$#$matrix;

    # Sort based on the number of 1s and then by row index
    @row_strength = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } @row_strength;

    # Extract and return the sorted indices
    return map { $_->[1] } @row_strength;
}

# Test the function
my @result1 = weakest_row([
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 1]
]);
print "@result1\n"; # Should print 2 0 3 1 4

my @result2 = weakest_row([
    [1, 0, 0, 0],
    [1, 1, 1, 1],
    [1, 0, 0, 0],
    [1, 0, 0, 0]
]);
print "@result2\n"; # Should print 0 2 3 1
