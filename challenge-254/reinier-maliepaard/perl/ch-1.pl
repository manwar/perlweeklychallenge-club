#!/usr/bin/perl
use strict;
use warnings;
use Math::BigInt;

sub three_power {
    my ($n) = @_;
    die "Invalid input! Input integer > 0"
        unless defined $n && $n =~ /^\d+$/ && $n > 0;

    return 1162261467 % $n == 0 ? "true" : "false";
}

# The previous function works for 32-bit integers.
# The following version handles arbitrarily large integers (Math::BigInt).

sub three_power_big {
    my ($n) = @_;
    die "Invalid input! Input integer > 0"
        unless defined $n && $n =~ /^\d+$/ && $n > 0;

    my $x = Math::BigInt->new($n);

    while ($x->copy()->bmod(3)->is_zero()) {
        # Use a copy so the original $x is not modified by bmod
        # Check: is $x divisible by 3?

        $x->bdiv(3);
        # Now safely divide the original $x by 3
    }

    return $x->is_one() ? "true" : "false";
}

# Tests


# Example 1
print three_power("27"), "\n"; # Output: true

# Example 2
print three_power("6"), "\n"; # Output: false

# Example 3
print three_power_big("27"), "\n"; # Output: true

# Example 4
print three_power_big("3486784401"), "\n"; # Output: true

# Example 5
print three_power_big("100000000000000000000"), "\n"; # Output: false
