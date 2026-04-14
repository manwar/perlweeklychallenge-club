#!/usr/bin/perl
use strict;
use warnings;

sub rm {
    my ($num) = @_;

    # allow only positive integers (no minus sign)
    die "Error: positive numbers only\n" if $num =~ /^-/;

    $num =~ s/^0+//;

    # handle case like "0" or "0000"
    $num = -1 if $num eq "";

    return $num;
}


# Tests

my $num;

# Example 1
$num = "0456";
print rm($num), "\n"; # Output: 456

# Example 2
$num = "000123";
print rm($num), "\n"; # Output: 123

# Example 3
$num = "0";
print rm($num), "\n"; # Output: -1

# Example 4
$num = "0000";
print rm($num), "\n"; # Output: -1

# Example 5
$num = "1010";
print rm($num), "\n"; # Output: 1010
