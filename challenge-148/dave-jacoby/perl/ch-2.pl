#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

use Algorithm::Permute;

my @triplets;

my $i = 0;
while ( scalar @triplets < 5 ) {
    for my $j ( 1 .. $i ) {
        for my $k ( 1 .. $j ) {
            my $p = Algorithm::Permute->new( [ $i, $j, $k ] );
            while ( my @res = $p->next ) {
                my $t = test_cardano(@res);
                if ( $t == 1 ) {
                    push @triplets, \@res;
                }
            }
        }
    }
    $i++;
    last if $i > 1000;
}

for my $ct (@triplets) {
    my ( $a, $b, $c ) = $ct->@*;
    print <<"END";
    A: $a\tB: $b\tC: $c
END
}

sub test_cardano ( $a, $b, $c ) {
    my $sqrtc = sqrt $c;

    # not necessary for the first five
    if ( $a > $b * $sqrtc ) {
        return cuberoot( $a + $b * $sqrtc ) + cuberoot( $a - $b * $sqrtc );
    }

    return cuberoot( $a + $b * $sqrtc ) +
        -1 * cuberoot( abs( $a - $b * $sqrtc ) );
}

sub cuberoot ($n ) { return $n**( 1 / 3 ) }
