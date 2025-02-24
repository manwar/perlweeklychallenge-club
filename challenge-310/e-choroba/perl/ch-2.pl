#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ part };
use List::Util qw{ mesh };

sub sort_odd_even(@ints) {
    my $part = 0;
    my $sort = -1;

    return [grep defined, mesh(map {
        $sort *= -1;
        [ sort { $sort * $a <=> $sort * $b } @$_ ]
    } part { $part++ % 2 } @ints)]
}

use Test::More tests => 3 + 1;

is_deeply sort_odd_even(4, 1, 2, 3), [2, 3, 4, 1], 'Example 1';
is_deeply sort_odd_even(3, 1), [3, 1], 'Example 2';
is_deeply sort_odd_even(5, 3, 2, 1, 4), [2, 3, 4, 1, 5], 'Example 3';

is_deeply sort_odd_even(3), [3], 'Single element';
