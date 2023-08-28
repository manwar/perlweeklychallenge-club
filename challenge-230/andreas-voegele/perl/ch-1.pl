#!/usr/bin/perl

# Write a script to separate an array of integers into single digits.

use 5.036;
use utf8;

sub separate_digits (@ints) {
    return map { split // } @ints;
}

sub print_array (@array) {
    return say '(', join(', ', @array), ')';
}

print_array(separate_digits(1, 34, 5,  6));
print_array(separate_digits(1, 24, 51, 60));
