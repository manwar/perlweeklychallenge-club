#!/usr/bin/perl
use strict;
use warnings;

# Assumptions:
# - Input values are within 0..n
# - No duplicates
# If those assumptions break, behavior might be unexpected

sub missing_values {

    my ($arr) = @_;

    my %seen = map {$_ => 1} @$arr;
    my @res;

    for my $val (0 .. @$arr) {

        push @res, $val unless $seen{$val};

    }
    return \@res;

}

# Alternative solution

sub missing_values_alt{

    my ($arr) = @_;

    my %seen = map {$_ => 1} @$arr;
    return grep { !exists $seen{$_} } 0 .. @$arr;

}

# Tests

# Example 1
print join(", ", @{ missing_values([0,1,3]) }), "\n"; # Output: 2

# Example 1
print join(", ", @{ missing_values([0,1]) }), "\n"; # Output: 2

# Example 1
print join(", ", @{ missing_values([0,2,4,6,8]) }), "\n"; # Output: 1, 3, 5

