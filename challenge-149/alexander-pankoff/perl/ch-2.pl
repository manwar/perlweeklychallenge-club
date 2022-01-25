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

use List::Util qw(sum0 first uniq);

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
    my $x = first {
        my $perfect_square = dec_to_base( $base, $_**2 );

        my @digits = split( '', $perfect_square );

        scalar uniq(@digits) == scalar @digits;
    }
    reverse( 0 .. int( sqrt( $base**$base - 1 ) ) );

    return dec_to_base( $base, $x**2 );
}

sub dec_to_base ( $base, $n ) {
    my @digits = ( 0 .. 9, 'A' .. 'Z' );

    return $digits[$n] if $n <= $base - 1;

    my $rem  = $n % $base;
    my $next = int( $n / $base );

    dec_to_base( $base, $next ) . $digits[$rem];
}
