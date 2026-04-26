#!/usr/bin/perl
use strict;
use warnings;

sub separate_digits {

    my ($aref) = @_;

    # Validate that all inputs are non-negative integers
    for (@$aref) {
        die "Input must contain only non-negative integers\n" unless /^\d+$/;
    }

    # If you always use split //, $_ on every number, it will:

    # - Split multi-digit numbers into their individual digits (e.g., 34 becomes 3, 4).
    # - Leave single-digit numbers as a single element (e.g., 5 becomes 5).

    my @res;
    for (@$aref) {
        push @res, split //, $_;
    }
    return @res;
}

# Tests

my @ints;

# Example 1
@ints = (1, 34, 5, 6);
print "(", join (, separate_digits(\@ints)), ")\n"; # Output: (1, 3, 4, 5, 6)

# Example 2
@ints = (1, 24, 51, 60);
print "(", join (, separate_digits(\@ints)), ")\n"; # Output: (1, 2, 4, 5, 1, 6, 0)
