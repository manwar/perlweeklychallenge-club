#!/usr/bin/env perl

use strict ;
use warnings ;
use feature qw{ say postderef signatures } ;
no warnings qw{ experimental } ;

use JSON ;
use List::Compare;

my $json = JSON->new->canonical ;

my @examples ;
push @examples, [ [ 1, 2, 5, 3, 4 ], [ 4, 6, 7, 8, 9 ] ] ;
push @examples, [ [ 1, 3, 5, 7, 9 ], [ 0, 2, 4, 6, 8 ] ] ;


for my $e ( @examples ) {
    my ( $s1,$s2 ) = $e->@*;
    say $json->encode($s1);
    say $json->encode($s2);
    say is_disjoint_sets($s1,$s2);
    say '';
}

sub is_disjoint_sets( $s1,$s2) {
    my $lc = List::Compare->new( '-u', $s1,$s2 );
    my @inter = $lc->get_intersection;
    return scalar @inter ? 1 : 0;
}
