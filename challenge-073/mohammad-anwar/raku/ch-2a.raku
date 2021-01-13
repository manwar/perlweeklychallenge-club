#!/usr/bin/env raku

#
# Perl Weekly Challenge - 073
#
# Task #2: Smallest Neighbour
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

use Test;

my %test-cases = (
    "7,  8, 3, 12, 10" => "0, 7, 0, 3, 3",
    "0,  1, 5,  2,  3" => "0, 0, 0, 0, 0",
    "1, -2, 7,  5, -4" => "0, 0, -2, -2, 0",
);

for %test-cases.keys.sort -> $list {
    is smallest-neighbour($list).join(', '),
       %test-cases{$list},
       "testing list $list";
}

done-testing;

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
