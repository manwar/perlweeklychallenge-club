#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental qw( signatures );

sub last_element(@ints) {
    while (@ints > 1) {
        @ints = sort { $a <=> $b } @ints;
        if ($ints[-1] == $ints[-2]) {
            splice @ints, -2;
        } else {
            push @ints, pop(@ints) - pop @ints;
        }
    }
    return $ints[0] // 0
}

use Test::More tests => 2;

is last_element(3, 8, 5, 2, 9, 2), 1, 'Example 1';
is last_element(3, 2, 5), 0, 'Example 2';
