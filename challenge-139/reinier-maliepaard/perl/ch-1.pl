#!/usr/bin/perl
use strict;
use warnings;

sub jort_sort {
    my ($aref) = @_;

    for my $i (1 .. $#$aref) {
        return 0 if $aref->[$i] < $aref->[$i - 1];
    }
    return 1;
}

# Alternative

sub jort_sort_alt {
    my ($aref) = @_;
    return (!grep { $aref->[$_] < $aref->[$_-1] } 1 .. $#$aref) ? 1 : 0;
}

# Tests
my @n;

# Example 1
@n = (1,2,3,4,5);
print jort_sort(\@n), "\n"; # Output: 1
# print jort_sort_alt(\@n), "\n"; # Output: 1

# Example 2
@n = (1,3,2,4,5);
print jort_sort(\@n), "\n"; # Output: 0
# print jort_sort_alt(\@n), "\n"; # Output: 0

# Example 3
@n = (1, 2, 2, 5);
print jort_sort(\@n), "\n"; # Output: 1
# print jort_sort_alt(\@n), "\n"; # Output: 1
