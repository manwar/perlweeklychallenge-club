#!/usr/bin/perl
use warnings;
use strict;
use experimental qw{ signatures };

use List::Util qw{ uniq };

sub divisor_last_digit ($m, $n) {
    my $count = 0;
    for my $d_small (1 .. sqrt $m) {
        next unless 0 == $m % $d_small;

        for my $d (uniq($d_small, $m / $d_small)) {
            ++$count if $n eq substr $d, -1;
        }
    }
    return $count
}

use Test2::V0;
plan 3;

# 2 12
is divisor_last_digit(24, 2), 2, 'Example 1';

# 5 15
is divisor_last_digit(30, 5), 2, 'Example 2';

# 10 20 40 50 80 100 200 250 400 500 1000 2000
is divisor_last_digit(2000, 0), 12, 'Two thousand';
