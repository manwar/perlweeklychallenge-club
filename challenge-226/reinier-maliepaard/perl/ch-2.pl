#!/usr/bin/perl
use strict;
use warnings;

sub zero_array_1 {

    my (@a) = @_;
    my %h;
    foreach (@a) {
        $h{$_} = 1 if ($_ != 0);
    }
    return scalar keys %h;
}

# a bit shorter with grep

sub zero_array_2 {

    my (@a) = @_;
    my %h;
    return scalar grep { ! $h{$_}++ if ($_ != 0) } @a;
}

# Tests

my @a;

# Example 1
@a = (1, 5, 0, 3, 5);
print zero_array_1(@a), "\n"; # Output: 3
print zero_array_2(@a), "\n"; # Output: 3

# Example 2
@a = (0);
print zero_array_1(@a), "\n"; # Output: 0
print zero_array_2(@a), "\n"; # Output: 0

# Example 3
@a = (2, 1, 4, 0, 3);
print zero_array_1(@a), "\n"; # Output: 4
print zero_array_2(@a), "\n"; # Output: 4
