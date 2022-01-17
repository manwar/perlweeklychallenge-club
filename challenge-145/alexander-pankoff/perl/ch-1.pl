#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

use Data::Dumper;
use List::Util qw(sum0 min);

run() unless caller();

sub run() {
    my @a = ( 1, 2, 3 );
    my @b = ( 4, 5, 6 );

    my $dot_product = dot_product( \@a, \@b );

    say $dot_product;

}

sub dot_product ( $a, $b ) {
    sum0( zip_with( sub ( $a, $b ) { $a * $b }, $a, $b ) );

}

sub zip_with ( $op, $as, $bs ) {
    map { $op->($as->[$_], $bs->[$_] ) } 0 .. min( $#{$as}, $#{$bs} );
}

