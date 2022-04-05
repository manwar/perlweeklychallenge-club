#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use List::Util qw{ uniq };
use Math::Prime::Util qw{ factor };

sub moebius_number ($n) {
    my @f = factor($n);

    return  0 if @f != uniq(@f);
    return -1 if @f % 2;
    return  1
}

use Test::More tests => 4;

is moebius_number(5), -1, 'Example 1';
is moebius_number(10), 1, 'Example 2';
is moebius_number(20), 0, 'Example 3';

is moebius_number(100), 0, 'Even number of prime factors but square';
