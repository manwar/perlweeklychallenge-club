#!/usr/bin/env raku

#
# Perl Weekly Challenge - 079
#
# Task #2: Trapped Rain Water
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use Test;

subset PositiveInt of Int where * >= 0;

is trapped-rain-water(0, 1, 2, 3, 4, 5),
   0, "testing: 0, 1, 2, 3, 4, 5";
is trapped-rain-water(3, 1, 3, 1, 1, 5),
   6, "testing: 3, 1, 3, 1, 1, 5";
is trapped-rain-water(2, 1, 4, 1, 2, 5),
   6, "testing: 2, 1, 4, 1, 2, 5";
is trapped-rain-water(0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1),
   6, "testing: 0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1";

done-testing;

#
#
# SUBROUTINES

sub trapped-rain-water(*@array where .all ~~ PositiveInt) {

    my @a   = ();
    my $p   = 0;
    my $trw = 0;
    for @array -> $n {
        if $p == 0 || $p >= $n {
            $p = $n if @a == 0 || ($p == 0 && $n > $p);
            @a.push: $n;
        }
        else {
            @a.push: $n;
            $trw += fetch-trapped-water(@a);
            @a = $n;
            $p = $n if $p < $n;
        }
    }

    # are there any left over to be processed?
    if @a.elems > 1 {
        $trw += fetch-trapped-water(@a);
    }

    return $trw;
}

sub fetch-trapped-water(*@array where .all ~~ PositiveInt) {

    # remove any smaller tower from the start
    repeat {
        if @array[0] == 0 {
            @array.shift;
        }
    } until @array[0] > 0;

    # remove any smaller tower from the end
    repeat {
        if @array[*-1] < @array[*-2] {
            @array.pop;
        }
    }
    until @array[*-1] > @array[*-2];

    my $max = (@array[0], @array[*-1]).min * (@array.elems - 2);
    $max -= @array[$_] for 1..@array.elems - 2;

    return $max;
}
