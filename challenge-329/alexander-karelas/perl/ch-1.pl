#!/usr/bin/env perl

use v5.42;

use Test2::V0;
use List::Util 'uniq';

sub counter_integers ($str) {
    $str =~ s/[^\d]/ /ag;
    return uniq($str =~ /\d+/ag);
}

is [counter_integers("the1weekly2challenge2")], [1, 2], 'Example 1';
is [counter_integers("go21od1lu5c7k")], [21, 1, 5, 7], 'Example 2';
is [counter_integers("4p3e2r1l")], [4, 3, 2, 1], 'Example 3';

done_testing;