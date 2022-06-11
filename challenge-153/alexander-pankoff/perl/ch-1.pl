#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
no warnings qw'experimental::signatures';

use List::Util qw(sum0 product);

run() unless caller();

sub run() {
    say join( ', ', left_factorials( 1, 10 ) );
}

sub left_factorials ( $from, $to ) {
    return map { left_factorial($_) } $from .. $to;
}

sub left_factorial($n) {
    return sum0( map { fac($_) } 0 .. ( $n - 1 ) );
}

sub fac($n) {
    product( 1 .. $n );
}
