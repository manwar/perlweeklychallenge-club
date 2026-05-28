#!/usr/bin/perl
use strict;
use warnings;

sub find_k_beauty {

    my ($num, $k) = @_;

    return -1 unless defined $num && defined $k;
    return -1 unless $k =~ /^\d+$/ && $k > 0;
    return -1 unless $num =~ /^\d+$/;
    return -1 if $k > length($num);

    my $count = 0;

    # Store the length once to avoid recalculating it
    my $len = length $num;

    for my $i (0 .. $len - $k) {

        my $part = substr($num, $i, $k);

        # Skip if the substring is zero,
        # because division/modulo by zero is illegal
        next if $part == 0;

        # If $part divides $num evenly, increment the counter
        #
        # Many Perl programmers prefer ++$count when the
        # incremented value itself is not being used.
        # $count++ would also work here.
        ++$count if $num % $part == 0;
    }

    return $count;
}

# Tests
my ($num, $k);

# Example 1
$num = 240;
$k = 2;
print find_k_beauty($num, $k), "\n"; # Output: 2

# Example 2
$num = 1020;
$k = 2;
print find_k_beauty($num, $k), "\n"; # Output: 3

# Example 3
$num = 444;
$k = 2;
print find_k_beauty($num, $k), "\n"; # Output: 0

# Example 4
$num = 17;
$k = 2;
print find_k_beauty($num, $k), "\n"; # Output: 1

# Example 5
$num = 123;
$k = 1;
print find_k_beauty($num, $k), "\n"; # Output: 2
