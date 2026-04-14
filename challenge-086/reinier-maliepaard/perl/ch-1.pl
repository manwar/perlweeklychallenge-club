#!/usr/bin/perl
use strict;
use warnings;

sub pair_diff {
    my ($A, $N) = @_;

    for (@$N) {
        my $sum = $_ + $A;
        return "true" if grep { $_ == $sum } @$N; # Cons: runs through the whole array every time
    }

    return "false";
}

# Alternative (and better performance for large arrays)

sub pair_diff_alt {
    my ($A, $N) = @_;

    my %seen = map { $_ => 1 } @$N;

    for (@$N) {
        return "true" if exists $seen{$_ + $A}; # hash: remember everything once, then check instantly
    }

    return "false";
}

# Tests
my @N;
my $A;

# Example 1
@N = (10, 8, 13, 5, 15);
$A = 7;
print pair_diff($A, \@N), "\n"; # Output: 1

# Example 2
Input: @N = (1, 5, 2, 9, 7);
$A = 6;
print pair_diff($A, \@N), "\n"; # Output: 1

# Example 3
@N = (10, 30, 20, 50, 40);
$A = 15;
print pair_diff($A, \@N), "\n"; # Output: 0
