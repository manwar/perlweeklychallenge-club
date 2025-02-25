#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub arrange_binary($digits, $n) {
    my $replacable = 0;
    my $is_blocked = 0;
    for my $i (0 .. $#$digits) {
        if (1 == $digits->[$i]) {
            $is_blocked = 1;
            next
        }
        next if $i < $#$digits && 1 == $digits->[ $i + 1 ];
        if ($is_blocked) {
            undef $is_blocked;
            next
        }
        ++$replacable;
        $is_blocked = 1;
    }
    return $replacable >= $n
}

use Test2::V0;
plan 2 + 6;

is arrange_binary([1, 0, 0, 0, 1], 1), bool(1), 'Example 1';
is arrange_binary([1, 0, 0, 0, 1], 2), bool(0), 'Example 2';

is arrange_binary([1, 0, 0], 1), bool(1), 'right edge';
is arrange_binary([0, 0, 1], 1), bool(1), 'left edge';
is arrange_binary([1, 0, 0, 0, 0, 1], 2), bool(0),
    '0x4 between 1s, n=2';
is arrange_binary([1, 0, 0, 0, 0, 0, 1], 2), bool(1),
    '0x5 between 1s, n=2';
is arrange_binary([0, 0, 0, 0, 0], 3), bool(1),
    '0x5, n=3';
is arrange_binary([0, 0, 0, 0, 0], 4), bool(0),
    '0x5, n=4';
