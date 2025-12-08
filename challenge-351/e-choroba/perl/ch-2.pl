#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub arithmetic_progression(@num) {
    my @sorted = sort { $a <=> $b } @num;
    my $d = $sorted[1] - $sorted[0];
    for my $i (2 .. $#sorted) {
        return if $sorted[$i] - $sorted[ $i - 1 ] != $d;
    }
    return 1
}

use Test2::V0;
plan(5);

use constant {true => !0, false => !1};

is arithmetic_progression(1, 3, 5, 7, 9), bool(true), 'Example 1';
is arithmetic_progression(9, 1, 7, 5, 3), bool(true), 'Example 2';
is arithmetic_progression(1, 2, 4, 8, 16), bool(false), 'Example 3';
is arithmetic_progression(5, -1, 3, 1, -3), bool(true), 'Example 4';
is arithmetic_progression(1.5, 3, 0, 4.5, 6), bool(true), 'Example 5';
