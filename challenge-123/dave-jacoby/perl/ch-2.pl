#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

use JSON;

my $json = JSON->new->canonical;
my @data = (
    [ [ 10, 20 ], [ 20, 20 ], [ 20, 10 ], [ 10, 10 ], ],
    [ [ 12, 24 ], [ 16, 10 ], [ 20, 12 ], [ 18, 16 ], ],
    [ [ 40, 40 ], [ 50, 30 ], [ 40, 20 ], [ 30, 30 ], ],
    [ [ 10, 10 ], [ 15, 15 ], [ 20, 15 ], [ 15, 10 ], ],
);

for my $d (@data) {
    say $json->encode($d);
    say is_square($d);
    say '';
}

sub is_square($d) {
    my @objs = $d->@*;
    my @distances;
    push @distances, distance( @objs[ 0, 1 ] ); # A -> B
    push @distances, distance( @objs[ 1, 2 ] ); # B -> C
    push @distances, distance( @objs[ 2, 3 ] ); # C -> D
    push @distances, distance( @objs[ 3, 0 ] ); # D -> A

    push @distances, distance( @objs[ 0, 2 ] ); # A -> C
    push @distances, distance( @objs[ 1, 3 ] ); # B -> D

    # sides are of equal length
    return 0 if $distances[0] != $distances[1];
    return 0 if $distances[1] != $distances[2];
    return 0 if $distances[2] != $distances[3];
    return 0 if $distances[3] != $distances[0];

    # distances throught the center are of equal length
    # removing parallelograms
    return 0 if $distances[4] != $distances[5];

    return 1;
}

sub distance ( $p1, $p2 ) {
    return
        sqrt( ( ( $p1->[0] - $p2->[0] )**2 ) +
            ( ( $p1->[1] - $p2->[1] )**2 ) );
}

