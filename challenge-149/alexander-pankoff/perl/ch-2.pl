#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say state signatures';
use bignum;
no warnings qw'experimental::signatures';

# TASK #2 › Largest Square
# Submitted by: Roger Bell_West
#
# Given a number base, derive the largest perfect square with no repeated digits and return it as a string. (For base>10, use ‘A’..‘Z’.)
# Example:
#
#     f(2)="1"
#     f(4)="3201"
#     f(10)="9814072356"
#     f(12)="B8750A649321"

use List::Util qw(uniq);

run() unless caller();

sub run() {

    my ($N) = @ARGV;

    if ( !$N || $N !~ m/^\d+$/ || $N < 2 || $N > 36 ) {
        die <<EOF;
  Usage:

    $0 N

  Options:

    N - a number base (between 2 and 36)
EOF
    }

    say "f($N) = " . largest_perfet_square_without_repeated_digits_in_base($N);

}

sub largest_perfet_square_without_repeated_digits_in_base($base) {
    my @digits = ( 0 .. 9, 'A' .. 'Z' )[ 0 .. $base - 1 ];

    for (
        my $i =
        int( sqrt( base_to_dec( $base, join( '', reverse @digits ) ) ) ) ;
        $i > 0 ;
        $i--
      )
    {
        my $perfect_square = dec_to_base( $base, $i**2 );

        my @digits = split( '', $perfect_square );

        return $perfect_square if scalar uniq(@digits) == scalar @digits;

    }
}

sub dec_to_base ( $base, $n ) {
    my @digits = ( 0 .. 9, 'A' .. 'Z' );

    return $digits[$n] if $n <= $base - 1;

    my $rem  = $n % $base;
    my $next = int( $n / $base );

    dec_to_base( $base, $next ) . $digits[$rem];
}

sub base_to_dec ( $base, $n ) {
    my $power = 1;
    my $num   = 0;

    my @digits = split( '', $n );

    for my $i ( reverse( 0 .. $#digits ) ) {

        $num += value( $digits[$i] ) * $power;
        $power = $power * $base;

    }

    return $num;

}

sub value($c) {

    if ( $c ge '0' && $c le '9' ) {
        return ord($c) - ord('0');

    }

    return ord($c) - ord('A') + 10;
}
