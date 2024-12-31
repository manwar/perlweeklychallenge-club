#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub step_by_step(@ints) {
    my $s   = 0;
    my $min = 0;
    for my $int (@ints) {
        $s += $int;
        $min = $s if $s < $min;
    }
    return 1 - $min
}

use Test::More tests => 3;

is step_by_step(-3, 2, -3, 4, 2), 5, 'Example 1';
is step_by_step(1, 2), 1, 'Example 2';
is step_by_step(1, -2, -3), 5, 'Example 3';
