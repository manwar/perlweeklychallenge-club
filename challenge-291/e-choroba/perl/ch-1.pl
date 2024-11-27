#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub middle_index(@ints) {
    my $left_sum  = 0;
    my $right_sum = sum(@ints);
    for my $i (0 .. $#ints) {
        $right_sum -= $ints[$i];
        return $i if $left_sum == $right_sum;

        $left_sum  += $ints[$i];
    }
    return -1
}

use Test::More tests => 3 + 1;

is middle_index(2, 3, -1, 8, 4), 3, 'Example 1';
is middle_index(1, -1, 4), 2, 'Example 2';
is middle_index(2, 5), -1, 'Example 3';

is middle_index(1, 2, -2), 0, 'Zero';
