#!/usr/bin/env perl

use v5.38;

sub odd_character ( $s, $t ) {
    my @sorted_s = sort( split( //, $s ) );
    my @sorted_t = sort( split( //, $t ) );
    for ( 0 .. @sorted_s - 1 ) {
        if ( $sorted_s[$_] ne $sorted_t[$_] ) {
            return $sorted_t[$_];
        }
    }
    return $sorted_t[-1];
}

sub MAIN() {
    if ( @ARGV > 1 ) {

        #| Run on command line argument
        say odd_character( $ARGV[1], $ARGV[2] );
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 3;

        is odd_character( 'Perl',   'Peerl' ),   'e', 'works for "Perl"';
        is odd_character( 'Weekly', 'Weeakly' ), 'a', 'works for "Weekly"';
        is odd_character( 'Box',    'Boxy' ),    'y', 'works for "Box"';
    }
}

MAIN();
