#!/usr/bin/perl
use strict;
use warnings;

# Trying to avoid determining the maximum value separately first...
sub twice_largest {

    my ($max_value, $max_index, $next_largest) = ($_[0], 0, -1);

    for my $i (1 .. $#_) {

        if ($_[$i] > $max_value) {
            ($max_value, $max_index, $next_largest) = ($_[$i], $i, $max_value);
        } elsif ($_[$i] > $next_largest) {
            $next_largest = $_[$i];
        }

    }

    return ( $max_value >= (2 * $next_largest) ) ? $max_index : -1;
}

# Tests

my @ints;

# Example 1
@ints = (2, 4, 1, 0);
print(twice_largest(@ints), "\n"); # Output: 1

# Example 2
@ints = (1, 2, 3, 4);
print(twice_largest(@ints), "\n"); # Output: -1

# Example 3
# test Laurent Rosenfeld
@ints = (4, 3, 5, 12, 2);
print(twice_largest(@ints), "\n"); # Output: 3
