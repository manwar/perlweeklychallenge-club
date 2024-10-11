#!/usr/bin/env perl

# Challenge 290
#
# Task 2: Luhn's Algorithm
# Submitted by: Andrezgz
#
# You are given a string $str containing digits (and possibly other characters
# which can be ignored). The last digit is the payload; consider it separately.
# Counting from the right, double the value of the first, third, etc. of the
# remaining digits.
#
# For each value now greater than 9, sum its digits.
#
# The correct check digit is that which, added to the sum of all values, would
# bring the total mod 10 to zero.
#
# Return true if and only if the payload is equal to the correct check digit.
#
# It was originally posted on reddit.
# Example 1
#
# Input: "17893729974"
# Output: true
#
# Payload is 4.
#
# Digits from the right:
#
# 7 * 2 = 14, sum = 5
# 9 = 9
# 9 * 2 = 18, sum = 9
# 2 = 2
# 7 * 2 = 14, sum = 5
# 3 = 3
# 9 * 2 = 18, sum = 9
# 8 = 8
# 7 * 2 = 14, sum = 5
# 1 = 1
#
# Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero.
# The payload is indeed 4.
#
# Example 2
#
# Input: "4137 8947 1175 5904"
# Output: true
#
# Example 3
#
# Input: "4137 8974 1175 5904"
# Output: false

use Modern::Perl;

sub is_luhn {
    my($str) = @_;
    $str =~ s/\D//g;
    my $payload = 0+substr($str, -1, 1);
    my $sum = 0;
    my $factor = 2;
    for (my $i = length($str)-2; $i >= 0; $i--) {
        my $digit = $factor*substr($str, $i, 1);
        if ($digit > 9) {
            $sum += eval(join("+", split //, $digit));
        }
        else {
            $sum += $digit;
        }
        $factor = 3-$factor;
    }
    if (($sum + $payload) % 10 == 0) {
        return 1;
    }
    else {
        return 0;
    }
}

say is_luhn("@ARGV") ? "true" : "false";
