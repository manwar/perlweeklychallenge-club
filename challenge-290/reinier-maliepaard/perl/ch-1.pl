#!/usr/bin/perl
use strict;
use warnings;

sub double_exist {
    my @ints = @_;

    # typical "old-school" double for loop through all possible pairs of indices (i, j)
    for my $i (0 .. $#ints) {
        for my $j ($i + 1 .. $#ints) {
            # check if $ints[$i] is twice $ints[$j] or vice versa
            # not perlish, but I like parentheses, expressing a thought...
            return ("true") if ( ($ints[$i] == 2 * $ints[$j]) || ($ints[$j] == 2 * $ints[$i]) );
        }
    }

    return ("false");
}

# Tests
my @ints;

# Example 1
@ints = (6, 2, 3, 3);
print(double_exist(@ints), "\n"); # Output: true

# Example 2
@ints = (3, 1, 4, 13);
print(double_exist(@ints), "\n"); # Output: false

# Example 3
@ints = (2, 1, 4, 2);
print(double_exist(@ints), "\n"); # Output: true

# Example 4
@ints = (1, 2, 3);
print(double_exist(@ints), "\n"); # Output: true
