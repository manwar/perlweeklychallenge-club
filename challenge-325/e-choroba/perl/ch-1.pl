#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub consecutive_one(@binary) {
    my $l = my $max_l = 0;
    for my $i (0 .. $#binary) {
        if ($binary[$i]) {
            $max_l = $l if ++$l > $max_l;
        } else {
            $l = 0;
        }
    }
    return $max_l
}

use Test::More tests => 3;

is consecutive_one(0, 1, 1, 0, 1, 1, 1), 3, 'Example 1';
is consecutive_one(0, 0, 0, 0), 0, 'Example 2';
is consecutive_one(1, 0, 1, 0, 1, 1), 2, 'Example 3';
