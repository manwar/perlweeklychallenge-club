#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub mountain_array(@ints) {
    my $phase = -1;
    for my $i (1 .. $#ints) {
        my $cmp = $ints[ $i - 1 ] <=> $ints[$i];
        return if (sub {1}, sub { 1 == $i }, sub { 1 == $phase })[$cmp]->();

        $phase = 1 if 1 == $cmp;
    }
    return 1 == $phase ? 1 : 0
}

use Test2::V0;
plan(5 + 4);

use constant {true  => bool(1),
              false => bool(0)};

is mountain_array(1, 2, 3, 4, 5), false, 'Example 1';
is mountain_array(0, 2, 4, 6, 4, 2, 0), true, 'Example 2';
is mountain_array(5, 4, 3, 2, 1), false, 'Example 3';
is mountain_array(1, 3, 5, 5, 4, 2), false, 'Example 4';
is mountain_array(1, 3, 2), true, 'Example 5';

is mountain_array(1, 3, 4, 3, 5, 4), false, 'Two peaks';
is mountain_array(1, 3), false, 'Too short';
is mountain_array(1), false, 'Even shorter';
is mountain_array(), false, 'Empty';
