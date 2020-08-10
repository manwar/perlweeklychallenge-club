#!/usr/bin/env raku

#
# Perl Weekly Challenge - 073
#
# Task #1: Min Sliding Window
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073
#

use v6.d;

sub MAIN(Str :$A = "1, 5, 0, 2, 9, 3, 7, 6, 4, 8",
         Int :$S = 3) {
    min-sliding-window($A, $S).join(", ").say;
}

sub min-sliding-window(Str $list is copy, Int $size) {

    die "ERROR: Invalid list [$list].\n"
        unless $list ~~ /^[\-?\d\,?\s?]+$/;

    say $list;
    $list ~~ s:g/\s//;
    my $l = [ $list.split(',') ];

    die "ERROR: Invalid size [$size].\n"
        unless $size >= 2 && $size - 1 <= $l.elems;

    my $index = 0;
    my @min-sliding-window = Empty;

    while $index + $size - 1 < $l.elems {
        my $window = $l.[$index .. $index + $size - 1].map: { .Int };
        @min-sliding-window.push: min($window);
        $index++;
    }

    return @min-sliding-window;
}
