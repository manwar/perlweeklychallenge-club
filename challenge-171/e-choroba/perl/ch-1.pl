#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Prime::Util qw{ divisor_sum };

sub abundant_odd_numbers ($count) {
    my @aon;
    my $n = 3;
    while (@aon < $count) {
        push @aon, $n if divisor_sum($n) > 2 * $n;
        $n += 2;
    }
    return \@aon
}

use Test::More tests => 2;

is_deeply abundant_odd_numbers(1),
    [945], 'First Abundant Odd Number';

is_deeply abundant_odd_numbers(20),
    [945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985, 6435,
     6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925],
    'First 20 Abundant Odd Numbers';

