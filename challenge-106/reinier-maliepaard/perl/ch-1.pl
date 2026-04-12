#!/usr/bin/perl
use strict;
use warnings;

sub max_gap {
    my ($aref) = @_;

     # Validate type first
    return undef unless ref($aref) eq 'ARRAY';

    return 0 if (@$aref <= 1);

    for (@$aref) {
        return undef unless defined($_) && /^-?\d+$/;
    }

    my @sorted = sort { $a <=> $b } @$aref;

    my $max_gap = 0;
    for (my $i = 1; $i < @sorted; $i++) {
        my $gap = $sorted[$i] - $sorted[$i - 1];
        $max_gap = $gap if $gap > $max_gap;
    }

    return $max_gap;
}


# Tests

my @arr;

# Example 1
@arr = qw/2 9 3 5/;
print max_gap(\@arr), "\n"; # Output: 4

# Example 2
@arr = qw/1 3 8 2 0/;
print max_gap(\@arr), "\n"; # Output: 5

# Example 3
@arr = qw/5/;
print max_gap(\@arr), "\n"; # Output: 0

# Example 4 (special case)
@arr = qw//;
print max_gap(\@arr), "\n"; # Output: 0
