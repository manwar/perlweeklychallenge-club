#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ shuffle uniq };

sub six_out_of_49() {
    (shuffle(1 .. 49))[0 .. 5]
}

use constant TIMES => 100;
use Test::More tests => TIMES * (2 + 2 * 6);

for (1 .. TIMES) {
    my @so49 = six_out_of_49();
    for my $s (@so49) {
        cmp_ok $s, '<=', 50, 'upper bound';
        cmp_ok $s, '>=', 1, 'lower bound';
    }
    is scalar @so49, 6;
    is uniq(@so49), @so49, 'unique';
}
