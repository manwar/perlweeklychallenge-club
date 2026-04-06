#!/usr/bin/perl
use strict;
use warnings;

sub element_digit_sum {
    my $sum_elements = 0;
    $sum_elements += $_ foreach (@_);

    my $sum_digits = 0;
    $sum_digits += $_ foreach (split(//,join ("", (@_))));

    my $diff = abs($sum_elements - $sum_digits);
}

# TESTS

my @ints = ();

# Example 1
@ints = (1, 2, 3, 45)
print(element_digit_sum(@ints), "\n"); # Output: 36

# Example 2
@ints = (1, 12, 3)
print(element_digit_sum(@ints), "\n"); # Output: 9

# Example 3
# @ints = (1, 2, 3, 4)
print(element_digit_sum(@ints), "\n"); # Output: 0
