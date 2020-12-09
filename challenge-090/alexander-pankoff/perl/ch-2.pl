#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(sum0);

use Test::Simple tests => 20;

use constant VERBOSE => $ENV{VERBOSE} // 0;

{
    for ( 0 .. 19 ) {
        my ( $a, $b ) = map { int( rand( 1000 ) ) + 1 } 0 .. 1;
        my $expected = $a * $b;
        ok( ethopian_mul( $a, $b ) == $expected, "ethopian_mul($a, $b) = $a * $b = $expected" );
    }
}

sub ethopian_mul ( $a, $b ) {
    my @chain = ethopian_mul_chain( $a, $b );
    verbose( "halving $a, doubling $b, till $a becomes 1" );
    verbose( $_->[0] . ' & ' . $_->[1] ) for @chain;

    my @filtered = map { $_->[1] } grep { odd( $_->[0] ) } @chain;
    verbose( "taking right values where left value is odd" );
    verbose( $_ ) for @filtered;
    my $product = sum0( @filtered );
    verbose( "product is $product" );
    return $product;
}

sub ethopian_mul_chain ( $a, $b ) {
    return [ $a, $b ] if $a <= 1;

    # using bit shifts to avoid use of multiplication
    return ( [ $a, $b ], ethopian_mul_chain( $a >> 1, $b << 1 ) );
}

sub odd($x) {
    $x & 1;
}
