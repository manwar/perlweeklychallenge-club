#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

my $numbers = [ 1 .. 9 ];
my $array;

recurse_magic_box( $numbers, $array );

sub recurse_magic_box ( $numbers, $array ) {

    # numbers is the list of allowable numbers
    for my $n (@$numbers) {
        push @$array, $n;
        if ( check_magic_box($array) ) {
            recurse_magic_box( $numbers, $array );
        }
        pop @$array;
    }
}

sub check_magic_box ( $array ) {
    for my $n (@$array) {
        my $c = scalar grep { m{$n} } @$array;
        return 0 if $c > 1;
    }

    if ( scalar @$array == 9 ) {
        my $sum    = 15;
        my $checks = [
            [ 0, 1, 2 ],    # first row
            [ 3, 4, 5 ],    # second row
            [ 6, 7, 8 ],    # third row
            [ 0, 3, 6 ],    # first col
            [ 1, 4, 7 ],    # second col
            [ 2, 5, 8 ],    # third col
            [ 0, 4, 8 ],    # diagonal from top right
            [ 6, 4, 2 ],    # diagonal from bottom right
        ];
        for my $check (@$checks) {
            my $s = 0;
            for my $p (@$check) {
                $s += $array->[$p];
            }
            return 0 if $s != $sum;
        }
        say "\t" . join ' ', @$array[ 0 .. 2 ];
        say "\t" . join ' ', @$array[ 3 .. 5 ];
        say "\t" . join ' ', @$array[ 6 .. 8 ];
        say '';
    }
    return 1;
}
