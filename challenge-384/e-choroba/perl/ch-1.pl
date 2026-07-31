#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my @DIGITS = (0 .. 9, 'A' .. 'Z', 'a' .. 'z', '+', '/');
sub base_n($num, $base) {
    my $result = "";
    while ($num) {
        substr $result, 0, 0, $DIGITS[ $num % $base ];
        $num = ($num - $num % $base) / $base;
    }
    return $result
}

use Test::More tests => 5;

is base_n(42, 2), '101010', 'Example 1';
is base_n(15642094, 16), 'EEADEE', 'Example 2';
is base_n(493, 8), '755', 'Example 3';
is base_n(2228519, 36), '1BRJB', 'Example 4';
is base_n(123456789, 64), '7MyqL', 'Example 5';
