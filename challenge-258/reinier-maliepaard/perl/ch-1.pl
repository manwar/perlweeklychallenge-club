#!/usr/bin/perl
use strict;
use warnings;

sub count_even_digits_number {
    print( (scalar(grep { /^\d+$/ && length($_) % 2 == 0 }  @_)), "\n");
}

# TESTS

my @ints = ();

# Example 1
@ints = (10, 1, 111, 24, 1000);
count_even_digits_number(@ints); # Output: 3

# Example 2
@ints = (111, 1, 11111);
count_even_digits_number(@ints);# Output: 0

# Example 3
@ints = (2, 8, 1024, 256);
count_even_digits_number(@ints);# Output: 1
