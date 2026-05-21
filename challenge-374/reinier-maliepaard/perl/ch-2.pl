#!/usr/bin/perl
use strict;
use warnings;

# Why this approach is efficient:

# - scans the string only once (O(n))
# - avoids temporary array allocations
# - avoids sorting (which would be O(n log n))
# - uses constant extra memory (O(1))
# - /g avoids rescanning already matched parts of the string

sub largest_same_digits_numbers {

    my ($str) = @_;
    # Return -1 if the string contains non-digit characters
    return -1  if $str =~ /\D/;

    my $max = 0;

    while ($str =~ /((\d)\2*)/g) {
        # '>' forces numeric comparison
        # Note: comparison is numeric, not by digit frequency or length.
        $max = $1 if $1 > $max;
    }

    return $max;
}

# Tests
my $str;

# Example 1
$str = "6777133339";
print "Output: ", largest_same_digits_numbers($str), "\n"; # Output: 3333

# Example 2
$str = "1200034";
print "Output: ", largest_same_digits_numbers($str), "\n"; # Output: 4

# Example 3
$str = "44221155";
print "Output: ", largest_same_digits_numbers($str), "\n"; # Output: 55

# Example 4
$str = "88888";
print "Output: ", largest_same_digits_numbers($str), "\n"; # Output: 88888

# Example 5
$str = "11122233";
print "Output: ", largest_same_digits_numbers($str), "\n"; # Output: 222
