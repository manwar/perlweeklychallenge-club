#!/usr/bin/perl
use strict;
use warnings;

sub matching_members {

    my ($ints) = @_;

    my @ints_sorted = sort { $a <=> $b } @$ints;

    my $count = 0;
    for (my $i = 0; $i <= scalar (@$ints-1); $i++) {
        $count++ if $ints->[$i] == $ints_sorted[$i];
    }

    return $count;
}

# shorter alternative

sub matching_members_alt {

    my ($ints) = @_;

    my @ints_sorted = sort { $a <=> $b } @$ints;

    my $count = grep { $ints->[$_] == $ints_sorted[$_] } 0 .. scalar (@$ints-1);

    return $count;
}

# Tests

my @ints;

# Example 1
@ints = (1, 1, 4, 2, 1, 3);
print matching_members(\@ints), "\n"; # Output: 3

# Example 2
@ints = (5, 1, 2, 3, 4);
print matching_members(\@ints), "\n"; # Output: 0

# Example 3
@ints = (1, 2, 3, 4, 5);
print matching_members(\@ints), "\n"; # Output: 5
