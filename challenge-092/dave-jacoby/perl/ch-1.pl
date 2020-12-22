#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental::postderef experimental::signatures };

my @examples;
push @examples, [ 'abc', 'xyz' ];
push @examples, [ 'abb', 'xyy' ];
push @examples, [ 'sum', 'add' ];

for my $example (@examples) {
    say join "\t", $example->[0], $example->[1];
    say isomorphic_strings( $example->@* );
    say '';
}

sub isomorphic_strings ( $x, $y ) {
    my $hash;

    return 0 if length $x != length $y;

    for my $i ( 0 .. -1 + length $x ) {
        my $xl = substr( $x, $i, 1 );
        my $yl = substr( $y, $i, 1 );
        if ( !$hash->{$xl} ) {
            $hash->{$xl} = $yl;
        }
        else {
            return 0 if $hash->{$xl} ne $yl;
        }
    }

    return 1;
}
