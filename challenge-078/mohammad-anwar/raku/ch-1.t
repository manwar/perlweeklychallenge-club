#!/usr/bin/env raku

#
# Perl Weekly Challenge - 078
#
# Task #1: Leader Element
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use Test;

is-deeply leader-elements("9, 10, 7, 5, 6, 1"),
          (10, 7, 6, 1),
          "testing example 1";

is-deeply leader-elements("3, 4, 5"),
          (5),
          "testing example 2";

done-testing;

#
#
# METHOD

sub leader-elements(Str $list) {

    die "ERROR: Invalid list [$list].\n" unless $list ~~ /^[\-?\d\,?\s?]+$/;

    my @array = $list.split(',').map: { .Int };
    my $index = 0;
    my @leader-elements = Empty;
    for @array -> $n {
        if $index == @array.elems-1 {
            @leader-elements.push: $n;
        }
        else {
            @leader-elements.push: $n
                if $n > @array[$index+1 .. @array.elems-1].max;
        }
        $index++;
    }

    return |@leader-elements;
}
