#!/usr/bin/env raku

#
# Perl Weekly Challenge - 073
#
# Task #2: Smallest Neighbour
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

use v6.d;

sub MAIN(Str $list = "7, 8, 3, 12, 10") {
    say $list;
    smallest-neighbour($list).join(', ').say;
}

sub smallest-neighbour(Str $list is copy) {

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\s?\-?\d\,?\s?]+$/;

    $list ~~ s:g/\s//;
    my $l = [ $list.split(',') ];

    my @smallest_neighbour = 0;
    for 1 .. $l.elems - 1 -> $i {
        my $min = min( $l.[0 .. $i - 1].map: { .Int } );
        @smallest_neighbour.push: ($min < $l.[$i]) ?? ($min) !! (0);
    }

    return @smallest_neighbour;
}
