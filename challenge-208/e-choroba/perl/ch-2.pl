#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub duplicate_and_missing(@nums) {
    my %seen;
    my $duplicate;
    my $missing;
    for my $n (@nums) {
        if (exists $seen{$n}) {
            return [-1] if 1 < $seen{$n};  # Triplicate.

            $duplicate = $n;
        }
        ++$seen{$n};
    }
    return [-1] unless defined $duplicate;

    return [-1]
        if $seen{
            $missing = $duplicate + (exists $seen{ $duplicate + 1 } ? -1 : 1)
        };

    return [$duplicate, $missing]
}

use Test2::V0;
plan 3 + 4;

is duplicate_and_missing(1, 2, 2, 4), [2, 3], 'Example 1';
is duplicate_and_missing(1, 2, 3, 4), [-1], 'Example 2';
is duplicate_and_missing(1, 2, 3, 3), [3, 4], 'Example 3';

is duplicate_and_missing(1, 2, 2, 3), [-1], 'Duplicate but not missing';
is duplicate_and_missing(1, 2, 4, 5), [-1], 'Missing but not duplicate';
is duplicate_and_missing(2, 2, 3, 4), [2, 1], 'Missing at the beginning';
is duplicate_and_missing(2, 3, 3, 3), [-1], 'Triplicate';
