#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ uniq };

sub counter_integers($str) {
    return uniq(map 0 + $_, $str =~ /([0-9]+)/g)
}

use Test2::V0;
plan(3 + 2);

is [counter_integers('the1weekly2challenge2')], [1, 2], 'Example 1';
is [counter_integers('go21od1lu5c7k')], [21, 1, 5, 7], 'Example 2';
is [counter_integers('4p3e2r1l')], [4, 3, 2, 1], 'Example 3';

is [counter_integers('a00b0c')], [0], 'Leading zeros';
is [counter_integers('abc')], [], 'Empty';
