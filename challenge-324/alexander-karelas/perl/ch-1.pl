#!/usr/bin/env perl

use v5.40;

use Test2::V0;

sub form_2_dim ($ints, $r, $c) {
    my @matrix = map { [splice @$ints, 0, $c] } 1 .. $r;
    return '(' . join(', ', map {'[' . join(', ', @$_) . ']'} @matrix) . ')';
}

is form_2_dim([1, 2, 3, 4], 2, 2), '([1, 2], [3, 4])', 'Example 1';
is form_2_dim([1, 2, 3], 1, 3), '([1, 2, 3])', 'Example 2';
is form_2_dim([1, 2, 3, 4], 4, 1), '([1], [2], [3], [4])', 'Example 3';

done_testing();
