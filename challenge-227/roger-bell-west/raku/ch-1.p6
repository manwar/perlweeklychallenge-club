#! /usr/bin/raku

use Test;

plan 1;

is(friday13th(2023), 2, 'example 1');

sub friday13th($y) {
    my $f = 0;
    for (1 .. 12) -> $m {
        if (Date.new($y, $m, 13).day-of-week == 5 ) {
            $f++;
        }
    }
    return $f;
}
