#!/usr/bin/perl
use strict;
use warnings;

sub equal_list {

    my ($aref1, $aref2) = @_;
    return ( join ('', @$aref1) eq join ('', @$aref2) ) ? "true" : "false";
}

my (@a1, @a2);

# Example 1
@a1 = ("a", "bc");
@a2 = ("ab", "c");
print equal_list(\@a1, \@a2), "\n"; # Output: true

# Example 2
@a1 = ("a", "b", "c");
@a2 = ("a", "bc");
print equal_list(\@a1, \@a2), "\n"; # Output: true

# Example 3
@a1 = ("a", "bc");
@a2 = ("a", "c", "b");
print equal_list(\@a1, \@a2), "\n"; # Output: false

# Example 4
@a1 = ("ab", "c", "");
@a2 = ("", "a", "bc");
print equal_list(\@a1, \@a2), "\n"; # Output: true

# Example 5
@a1 = ("p", "e", "r", "l");
@a2 = ("perl");
print equal_list(\@a1, \@a2), "\n"; # Output: true
