#!/usr/bin/perl
use strict;
use warnings;

sub luhn_algorithm {

    # \D matches any non-digit character, g ensures all matches are replaced
    $_[0] =~ s/\D//g;

    # reversing the digits ensures that you always start processing
    # from the rightmost digit, regardless of whether the
    # total number of digits is odd or even.

    my @digits = reverse (split(//, $_[0]));

    my $sum = 0;

    # start at 1, skipping the payload value
    foreach my $i (1..$#digits) {
        my $digit = $digits[$i];

        # double every second digit depending on position
        if ($i % 2 == 1) {
            $digit *= 2;
            # if the result is greater than 9, add the digits of the result
            if ($digit > 9) {
                my @split_digits = split(//, $digit);
                $digit = $split_digits[0] + $split_digits[1];
            }
        }

        $sum += $digit;
    }

    # If the sum + $digits[0] (=payload) is divisible by 10, the number is valid
    ( ($sum += $digits[0]) % 10 == 0 ) ? return ("true") : return ("false");
}

# Tests

my $str;

# Example 1
$str = "17893729974";
print(luhn_algorithm($str), "\n"); # Output: true

# Example 2
$str = "4137 8947 1175 5904";
print(luhn_algorithm($str), "\n"); # Output: true

# Example 3
$str = "4137 8974 1175 5904";
print(luhn_algorithm($str), "\n"); # Output: false
