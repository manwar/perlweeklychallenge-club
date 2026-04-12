#!/usr/bin/perl
use strict;
use warnings;

sub max_index {
    my ($aref) = @_;

    # Validate: must be a non-empty array of non-negative integers
    return undef unless ref($aref) eq 'ARRAY' && @$aref;
    for (@$aref) {
        return undef unless defined($_) && $_ =~ /^\d+$/;
    }

    my $max = $aref->[0];
    my $ind = 0;
    for my $i (1 .. $#$aref) {
        if ($aref->[$i] > $max) {
            $max = $aref->[$i];
            $ind = $i;
        }
    }
    return $ind;
}

# Tests

my @n;

# Example 1
@n = (5, 2, 9, 1, 7, 6);
print max_index(\@n), "\n"; # Output: 2

# Example 1
@n = (4, 2, 3, 1, 5, 0);
print max_index(\@n), "\n"; # Output: 4
