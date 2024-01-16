#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum };

sub concatenation_value(@ints) {
    return sum(map $_ == $#ints - $_ ? $ints[$_]
                                     : $ints[$_] . $ints[ $#ints - $_ ],
               0 .. $#ints / 2)
}

use Test::More tests => 3;

is concatenation_value(6, 12, 25, 1), 1286, 'Example 1';
is concatenation_value(10, 7, 31, 5, 2, 2), 489, 'Example 2';
is concatenation_value(1, 2, 10), 112, 'Example 3';
