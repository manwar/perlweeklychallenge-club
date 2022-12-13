#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(mostfrequenteven([1, 1, 2, 6, 2]), 2, 'example 1');
is(mostfrequenteven([1, 3, 5, 7]), -1, 'example 2');
is(mostfrequenteven([6, 4, 4, 6, 1]), 4, 'example 3');

use List::Util qw(max);

sub mostfrequenteven($l) {
    my %f;
    foreach my $n (@{$l}) {
        if ($n % 2 == 0) {
            $f{$n}++;
        }
    }
    if (scalar %f > 0) {
        my $m = max(values %f);
        my @l = grep {$f{$_} == $m} keys %f;
        @l = sort @l;
        return $l[0];
    } else {
        return -1;
    }
}
