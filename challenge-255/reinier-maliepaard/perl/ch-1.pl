#!/usr/bin/perl
use strict;
use warnings;

sub odd_char {
    my ($s, $t) = @_;

    if (length($t) == (length($s) + 1)) {
        # the one that is not replaced, is the additional character!
        $t =~ s/$_//i for split('', $s);
        print("$t\n");
    }
    else {
        print("No valid input!");
    }
}

# TESTS

my ($s, $t);

# Example 1
$s = "Perl";
$t = "Preel";
odd_char($s, $t); # Output: e

# Example 2
$s = "Weekly";
$t = "Weeakly";
odd_char($s, $t); # Output: a

# Example 3
$s = "Box";
$t = "Boxy";
odd_char($s, $t); # Output: y
