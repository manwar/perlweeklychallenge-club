#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub is_disarium_number($n) {
    my $sum = 0;
    for my $pos (1 .. length $n) {
        $sum += substr($n, $pos - 1, 1) ** $pos;
    }
    return $sum == $n
}

sub disarium_numbers ($tally) {
    my @dn;
    my $candidate = 0;
    while (@dn < $tally) {
        push @dn, $candidate
            if is_disarium_number($candidate);
    } continue {
        ++$candidate;
    }
    return \@dn
}

use Test::More tests => 2;

ok is_disarium_number(518), 'Example';
is_deeply disarium_numbers(19),
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
     89, 135, 175, 518, 598, 1306, 1676, 2427, 2646798],
    'Requested list';  # https://oeis.org/A032799
