#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum };

my @list;
push @list, [ 1.2, 0.4, 0.1, 2.5 ];
push @list, [ 0.2, 1.5, 0.9, 1.1 ];
push @list, [ 0.5, 1.1, 0.3, 0.7 ];

for my $r (@list) {
    triplet_sum( $r->@* );
    say '';
}

sub triplet_sum ( @array ) {
    say join ', ', @array;
    my $arr->@* = @array;

    for ( 0 .. scalar $arr->@* ) {
        my $x   = shift $arr->@*;
        my $out = _triplet_sum( [$x], $arr );
        say 1 and return if $out;
        push $arr->@*, $x;
    }
    say 0;
}

sub _triplet_sum ( $trip, $stash ) {
    if ( 3 == scalar $trip->@* ) {
        my $sum = sum $trip->@*;
        if ( 1 < $sum && $sum < 2 ) {
            say join ' + ', $trip->@*;
            return 1;
        }
        return 0;
    }
    my $trip2->@*  = $trip->@*;
    my $stash2->@* = $stash->@*;
    for ( 0 .. scalar $stash2->@* ) {
        my $x = shift $stash2->@*;
        push $trip2->@*, $x;
        my $out = _triplet_sum( $trip2, $stash2 );
        return 1 if $out;
        push $stash2->@*, pop $trip2->@*;
    }
}
