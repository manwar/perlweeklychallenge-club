#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ max };

# You are given an array @A containing distinct integers.

# Write a script to find all leader elements in the array @A.
# Print (0) if none found.

# Input: @A = (9, 10, 7, 5, 6, 1)
# Output: (10, 7, 6, 1)

my @A;
@A = ( 9, 10, 7, 5, 6, 1 );
my @o1 = leader_element(@A);
say join ', ', @A;
say join ', ', @o1;
say '';

# Input: @A = (3, 4, 5)
# Output: (5)

@A = ( 3, 4, 5 );
my @o2 = leader_element(@A);
say join ', ', @A;
say join ', ', @o2;
say '';

sub leader_element ( @arr ) {
    my @output;

    while (@arr) {
        my $max = max @arr;
        push @output, $arr[0] if $max == $arr[0];
        shift @arr;
    }

    push @output, 0 unless scalar @output;
    return wantarray ? @output : \@output;
}
