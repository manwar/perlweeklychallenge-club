#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(straightline([[2, 1], [2, 3], [2, 5]]), 1, 'example 1');
is(straightline([[1, 4], [3, 4], [10, 4]]), 1, 'example 2');
is(straightline([[0, 0], [1, 1], [2, 3]]), 0, 'example 3');
is(straightline([[1, 1], [1, 1], [1, 1]]), 1, 'example 4');

sub straightline($a) {
    my @b;
    foreach my $xy (@{$a}) {
        my $u = 1;
        foreach my $bxy (@b) {
            if ($xy->[0] == $bxy->[0] && $xy->[1] == $bxy->[1]) {
                $u = 0;
                last;
            }
        }
        if ($u) {
            push @b, $xy;
        }
    }
    if (scalar @b < 3) {
        return 1;
    }
    my $p = $b[0][0];
    my $q = $b[1][0] - $b[0][0];
    my $r = $b[0][1];
    my $s = $b[1][1] - $b[0][1];
    foreach my $tp (2 .. $#b) {
        my $tpair = $b[$tp];
        if ($q == 0 && $tpair->[0] != $b[0][0]) {
            return 0;
        }
        if ($s == 0 && $tpair->[1] != $b[0][1]) {
            return 0;
        }
        if ($q != 0 && $s != 0) {
            my $n1 = ($tpair->[0] - $p ) / $q;
            my $n2 = ($tpair->[1] - $r ) / $s;
            if ($n1 != $n2) {
                return 0;
            }
        }
    }
    1;
}
