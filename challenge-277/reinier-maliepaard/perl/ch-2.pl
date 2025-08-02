#!/usr/bin/perl
use strict;
use warnings;

use List::Uniq ':all';
use Math::Combinatorics;

sub strong_pair {

    # Duplicate values are unnecessary and lead to duplicate pairs,
    # so they should be removed: uniq(@_);

    my $c = Math::Combinatorics->new ( count => 2, data => [uniq(@_)], );

    my $count = 0;

    while ( my @cmb = $c->next_combination ) {

        my $abs = abs($cmb[0] - $cmb[1]);
        # finding min(): ($x + $y + abs($x - $y)) / 2
        # https://www.perlmonks.org/?node_id=406883
        $count++ if ( ($abs < ($cmb[0] + $cmb[1] - $abs) / 2) && ($abs > 0) );

    }

    return ($count);
}

# TESTS

my @ints;

# Example 1
@ints = (1, 2, 3, 4, 5);
print(strong_pair(@ints), "\n"); # Output: 4

# Example 2
@ints = (5, 7, 1, 7);
print(strong_pair(@ints), "\n"); # Output: 1
