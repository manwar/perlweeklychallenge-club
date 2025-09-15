#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use List::Util qw/max/;

sub max_diff {
    my @nums = @_;

    # For 4 elements, there are only 3 possible pairings
    if (@nums == 4) {
        my ($a, $b, $c, $d) = @nums;
        return max(
            $a*$b - $c*$d,
            $a*$c - $b*$d,
            $a*$d - $b*$c,
        );
    }

    # For larger arrays, we need to consider extreme values
    my @s = sort {$a <=> $b} @nums;

    # The maximum difference will likely come from:
    # Option 1: (two largest) vs (two smallest)
    # Option 2: (largest*smallest) vs (second largest*second smallest)
    # Option 3: (largest*second smallest) vs (second largest*smallest)

    my $opt1 = $s[-1]*$s[-2] -  $s[0]*$s[1];
    my $opt2 = $s[-1]*$s[0]  - $s[-2]*$s[1];
    my $opt3 = $s[-1]*$s[1]  - $s[-2]*$s[0];

    return max($opt1, $opt2, $opt3);
}

is(max_diff(5,9,3,4,6),   42);
is(max_diff(1,-2,3,-4),   10);
is(max_diff(-3,-1,-2,-4), 10);
is(max_diff(10,2,0,5,1),  50);
is(max_diff(7,8,9,10,10), 44);

done_testing;
