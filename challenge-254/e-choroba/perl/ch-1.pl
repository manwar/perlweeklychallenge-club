#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub three_power($n) {
    for (1, 2) {
        return if $n % 3;
        $n /= 3;
    }
    return 1
}

use Test::More tests => 3 + 2;

ok three_power(27),  'Example 1';
ok three_power(0),   'Example 2';
ok ! three_power(6), 'Example 3';
ok three_power(18446703239944862784), 'Large true';
ok ! three_power(18446744073709551615), 'Large false';
