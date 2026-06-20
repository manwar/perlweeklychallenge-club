#!/usr/bin/perl
use strict;
use warnings;

# Two approaches here:
# 1. a hash based one
# 2. an array based one

# Solution 1

sub second_largest_digit_1 {
    my ($str) = @_;

    my %seen;

    # scan the string and return every digit it contains as a list.
    # modifier /g turns regex \d into a "loop over matches"
    # capture group is necessary; so /(\d)/ means "find a digit and capture it"
    # returning matched digits as a list
    $seen{$_} = 1 for $str =~ /(\d)/g;

    my @digits = sort { $b <=> $a } keys %seen;

    return @digits >= 2 ? $digits[1] : -1;
}

# Solution 2
# The array-based solution is better because it uses a fixed-size structure (0–9),
# making it more efficient and predictable than a hash. It avoids hashing overhead,
# guarantees constant memory usage, allows fast direct indexing to check digit presence,
# and avoids sorting entirely by scanning digits from 9 down to 0.

sub second_largest_digit_2 {
    my ($str) = @_;

    # boolean array: index = digit (0–9), value = 1 if digit exists
    my @seen;

    # see annotation in the first solution
    $seen[$_] = 1 for $str =~ /(\d)/g;

    my $c = 0;

    # loop from 9 down to 0 (largest digit -> smallest digit)
    for (reverse 0..9) {
        next if !$seen[$_];
        return $_ if ++$c == 2;
    }

    return -1;
}

# Tests

my $str;

# Example 1
$str = "aaaaa77777";
print second_largest_digit_1($str), "\n"; #  Output: -1
print second_largest_digit_2($str), "\n"; #  Output: -1

# Example 2
$str = "abcde";
print second_largest_digit_1($str), "\n"; # Output: -1
print second_largest_digit_2($str), "\n"; # Output: -1

# Example 3
$str = "9zero8eight7seven9";
print second_largest_digit_1($str), "\n"; # Output: 8
print second_largest_digit_2($str), "\n"; # Output: 8

# Example 4
$str = "xyz9876543210";
print second_largest_digit_1($str), "\n"; # Output: 8
print second_largest_digit_2($str), "\n"; # Output: 8

# Example 5
$str = "4abc4def2ghi8jkl2";
print second_largest_digit_1($str), "\n"; # Output: 4
print second_largest_digit_2($str), "\n"; # Output: 4
