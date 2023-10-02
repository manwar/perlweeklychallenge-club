#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub last_member(@ints) {
    @ints = sort { $b <=> $a } @ints;
    while (@ints > 1) {
        if ($ints[0] == $ints[1]) {
            splice @ints, 0, 2;
        } else {
            @ints = sort { $b <=> $a } @ints[2 .. $#ints], $ints[0] - $ints[1];
        }
    }
    return $ints[0] // 0
}

use Test::More tests => 3 + 1;

is last_member(2, 7, 4, 1, 8, 1), 1, 'Example 1';
is last_member(1), 1, 'Example 2';
is last_member(1, 1), 0, 'Example 3';

is last_member(10, 10, 2, 5), 3, 'Non-one';
