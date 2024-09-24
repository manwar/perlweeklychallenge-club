#!/usr/bin/perl
use strict;
use warnings;

sub is_palindrome {
    return ($_[0] eq reverse($_[0]));
}

sub find_closest_palindrome {
    my $input_num = shift;

    # both numbers are equally distant from the given input number
    my $decrement_num = $input_num - 1;
    my $increment_num = $input_num + 1;

    while (1) {
        # if there are more than one closest palindrome
        # then return the smallest
        if (is_palindrome($decrement_num)) {
            return $decrement_num;
        }
        if (is_palindrome($increment_num)) {
            return $increment_num;
        }
        $decrement_num--;
        $increment_num++;
    }
}

# Tests

my $str;

# Example 1
$str = "123";
print(find_closest_palindrome($str), "\n"); # Output: "121"

# Example 2
$str = "2";
print(find_closest_palindrome($str), "\n"); # Output: "1"

# Example 3
$str = "1400";
print(find_closest_palindrome($str), "\n"); # Output: "1441"

# Example 4
$str = "1001";
print(find_closest_palindrome($str), "\n"); # Output: "999"
