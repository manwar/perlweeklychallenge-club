#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub boomerang(@points) {
    my %distinct;
    @distinct{ map "@$_", @points } = ();
    return unless 3 == keys %distinct;

    my @vector01 = map $points[0][$_] - $points[1][$_], 0, 1;
    my @vector12 = map $points[1][$_] - $points[2][$_], 0, 1;
    return 0 if $vector01[1] == 0 && $vector12[1] == 0
             || $vector01[0] / $vector01[1] == $vector12[0] / $vector12[1];

    return 1
}

use Test::More tests => 6 + 3;

ok boomerang([1, 1], [2, 3], [3,2]), 'Example 1';
ok ! boomerang([1, 1], [2, 2], [3, 3]), 'Example 2';
ok boomerang([1, 1], [1, 2], [2, 3]), 'Example 3';
ok ! boomerang([1, 1], [1, 2], [1, 3]), 'Example 4';
ok ! boomerang([1, 1], [2, 1], [3, 1]), 'Example 5';
ok boomerang([0, 0], [2, 3], [4, 5]), 'Example 6';

ok ! boomerang([1, 1], [1, 1], [2, 3]), 'Not distinct';
ok ! boomerang([1, 1], [1, 1], [1, 1]), 'All the same';
ok ! boomerang([1, 1], [3, 3], [2, 2]), 'Different order';
