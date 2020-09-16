#!/usr/bin/env raku

#
# Perl Weekly Challenge - 078
#
# Task #2: Left Rotation
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use v6.d;

sub MAIN(Str :$A = "10, 20, 30, 40, 50", Str :$B = "3, 4") {
    left-rotation($A, $B).join("\n").say;
}

#
#
# METHOD

sub left-rotation(Str $source, Str $index) {

    die "ERROR: Invalid source [$source].\n"
        unless $source ~~ /^[\-?\d\,?\s?]+$/;
    die "ERROR: Invalid index  [$index].\n"
        unless $index  ~~ /^[\-?\d\,?\s?]+$/;

    my @source = $source.split(',').map: { .Int };
    my @index  = $index.split(',').map:  { .Int };

    my @left-rotation = Empty;
    for @index -> $i {
        my @array = Empty;
        for $i..@source.elems-1 -> $j {
            @array.push: @source.[$j];
        }
        if $i > 0 {
            for 0..$i-1 -> $k {
                @array.push: @source.[$k];
            }
        }

        @left-rotation.push: @array;
    }

    return |@left-rotation;
}
