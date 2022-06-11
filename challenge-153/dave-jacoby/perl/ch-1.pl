#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 product };

say join ', ', map { left_factorial($_) } 1 .. 10;

# Left factorials: !n = Sum_{k=0..n-1} k!.
sub left_factorial( $n ) {
    return sum0 map { factorial($_) } 0 .. $n - 1;
}

sub factorial ( $n ) {
    return 1 if $n == 0;
    state $factorials ;
    if ( !$factorials->{$n} ) {
        $factorials->{$n} = product 1 .. $n;
    }
    return $factorials->{$n};
}
