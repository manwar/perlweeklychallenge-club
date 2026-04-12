#!/usr/bin/perl
use strict;
use warnings;

# This solution uses nested loops and is suitable for small datasets.

sub sum_bitwise_operator {
    my ($aref) = @_;

    # Validate it's an array reference
    return undef unless ref($aref) eq 'ARRAY';

    my @n = @$aref;

    return 0 if @n <= 1;

    for (@n) {
        return undef unless defined($_) && /^\d+$/;
    }

    my $sum = 0;

    for my $i (0 .. $#n - 1) {
        for my $j ($i + 1 .. $#n) {
            $sum += $n[$i] & $n[$j];
        }
    }

    return $sum;
}


# Tests

my @n;

# Example 1
@n = (1, 2, 3);
print sum_bitwise_operator(\@n), "\n"; # Output: 3

# Example 2
@n = (2, 3, 4);
print sum_bitwise_operator(\@n), "\n"; # Output: 2
