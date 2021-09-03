#!/usr/bin/perl
use warnings;
use strict;

sub disjoint_sets {
    my ($s1, $s2) = @_;
    my %set;
    @set{@$s1} = ();
    delete @set{@$s2};

    # Check that nothing was removed, i.e. the number of keys stays the same.
    return (@$s1 == keys %set) ? 1 : 0
}

use Test2::V0;
plan 2;

is disjoint_sets([1, 2, 5, 3, 4], [4, 6, 7, 8, 9]), 0, 'Example 1';
is disjoint_sets([1, 3, 5, 7, 9], [0, 2, 4, 6, 8]), 1, 'Example 2';
