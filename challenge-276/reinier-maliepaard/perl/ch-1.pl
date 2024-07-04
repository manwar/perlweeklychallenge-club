#!/usr/bin/perl
use strict;
use warnings;

use Math::Combinatorics;

sub complete_day {

    my $c = Math::Combinatorics->new ( count => 2, data => [@_], );

    my $count = 0;

    while ( my @cmb = $c->next_combination ) {

        $count++ if ( ($cmb[0] + $cmb[1]) % 24 == 0 );

    }

    return ($count);
}

# Tests

my (@hours);

# Example 1
@hours = (12, 12, 30, 24, 24);
print(complete_day(@hours), "\n"); # Output: 2

# Example 2
@hours = (72, 48, 24, 5);
print(complete_day(@hours), "\n"); # Output: 3

# Example 3
@hours = (12, 18, 24);
print(complete_day(@hours), "\n"); # Output: 0
