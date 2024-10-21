#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub twice_largest(@ints) {
    return 0 if 1 == @ints;

    my @max = $ints[0] < $ints[1] ? (0, 1) : (1, 0);
    for my $i (2 .. $#ints) {
        if ($ints[$i] >= $ints[ $max[1] ]) {
            @max = ($max[1], $i);
        } elsif ($ints[$i] >= $ints[ $max[0] ]) {
            $max[0] = $i;
        }
    }
    return $ints[ $max[0] ] * 2 <= $ints[ $max[1] ]
           ? $max[1]
           : -1
}

use Test::More tests => 2 + 3;

is twice_largest(2, 4, 1, 0), 1, 'Example 1';
is twice_largest(1, 2, 3, 4), -1, 'Example 2';

is twice_largest(4, 4, 4, 3, 9), 4, 'More than twice';
is twice_largest(7, 3), 0, 'Two elements';
is twice_largest(5), 0, 'Single element';
