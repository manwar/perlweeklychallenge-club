#!/usr/bin/env perl

use v5.38;

# use Math qw/sqrt/;

sub three_power ($n) {
    my @powers = map( { $_**3 } 0 .. int( sqrt($n) ) );
    return grep( { $n == $_ } @powers ) ? 1 : 0;
}

sub MAIN() {
    if (@ARGV) {

        #| Run on command line argument
        say three_power( $ARGV[1] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;
        is three_power(27), 1, 'Works for 27';
        is three_power(0),  1, 'Works for 0';
        is three_power(6),  0, 'Works for 6';
    }
}

MAIN();
