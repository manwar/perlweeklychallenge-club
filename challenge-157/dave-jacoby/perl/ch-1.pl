#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum0 product };
use Math::BigFloat;

my @examples;
push @examples, [ 1, 3, 5, 6, 9 ];
push @examples, [ 2, 4, 6, 8, 10 ];
push @examples, [ 1, 2, 3, 4, 5 ];

for my $e (@examples) {

    my $am = round( arithmetic_mean( $e->@* ) );
    my $gm = round( geometric_mean( $e->@* ) );
    my $hm = round( harmonic_mean( $e->@* ) );
    my $ee = join ', ', $e->@*;
    say <<"END";
        Input:  \@n = ($ee)
        OUTPUT: AM = $am, GM = $gm, HM = $hm
END
}

sub arithmetic_mean ( @array ) {
    return ( sum0 @array ) / ( scalar @array );
}

sub geometric_mean ( @array ) {
    my $x = abs product @array;
    my $y = 1 / scalar @array;
    return $x**$y;
}

sub harmonic_mean ( @array ) {
    my $sm = sum0 map { 1 / $_ } @array;
    my $n  = scalar @array;
    return $n / $sm;
}

sub round( $n ) {
    return Math::BigFloat->new($n)->bfround(-1);
}
