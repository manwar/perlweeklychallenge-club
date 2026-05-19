#!/usr/bin/perl
use strict;
use warnings;

sub empty_array {
    my (@a) = @_;
    my $count = 0;

    while (@a) {

        my $min = $a[0];
        for (@a) {
            $min = $_ if $_ < $min;
        }

        if ($a[0] == $min) {
            shift @a;          # remove first element
        }
        else {
            push @a, shift @a; # move first to end
        }

        $count++;
    }

    return $count;
}

# Tests

my @a;

# Example 1
@a = (3, 4, 2);
print empty_array(@a), "\n"; # Output: 5

# Example 2
@a = (1, 2, 3);
print empty_array(@a), "\n"; # Output: 3
