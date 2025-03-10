#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my %BIT = (G => 1,
           R => 2,
           B => 4);
sub balls_and_boxes($str) {
    my @boxes;
    $boxes[$2] |= $BIT{$1} while $str =~ /(\w)(\d)/g;
    return grep 7 == ($_ // 0), @boxes
}

use Test::More tests => 3;

is balls_and_boxes('G0B1R2R0B0'), 1, 'Example 1';
is balls_and_boxes('G1R3R6B3G6B1B6R1G3'), 3, 'Example 2';
is balls_and_boxes('B3B2G1B3'), 0, 'Example 3';
