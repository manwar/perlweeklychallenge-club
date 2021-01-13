#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/

use Test;

is candies([1, 2, 2]), 5;
is candies([1, 4, 3, 2]), 7;

# candies [1, 2, 2];
# candies [1, 4, 2, 1, 5];
# candies [1, 2, 2, 1, 3];
# candies [1, 4, 2, 1, 5, 2, 3, 1, 1, 3, 2];

sub candies(@n) {
    my @candies = 1 xx @n.elems;

    my $s;

    repeat {
        $s = @candies.sum;

        @candies[0]++ if @n[0] > @n[1] && @candies[0] <= @candies[1];

        for 1 ..^ @n.end -> $i {
            @candies[$i]++ if @n[$i] > @n[$i - 1] && @candies[$i] <= @candies[$i - 1];
            @candies[$i]++ if @n[$i] > @n[$i + 1] && @candies[$i] <= @candies[$i + 1];
        }

        @candies[*-1]++ if (@n[*-1] > @n[*-2] && @candies[*-1] <= @candies[*-2]) || (@n[*-1] == @n[*-2] && @candies[*-1] < @candies[*-2]);

        say @candies;

    } until $s == @candies.sum;

    return $s;
}
