#!/usr/bin/env raku

#
# Perl Weekly Challenge - 078
#
# Task #2: Left Rotation
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use Test;

is-deeply [left-rotation("10, 20, 30, 40, 50", "3, 4")],
          [[40, 50, 10, 20, 30], [50, 10, 20, 30, 40]],
          "testing example 1";

is-deeply [left-rotation("7, 4, 2, 6, 3", "1, 3, 4")],
          [[4, 2, 6, 3, 7], [6, 3, 7, 4, 2], [3, 7, 4, 2, 6]],
          "testing example 2";

done-testing;

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
