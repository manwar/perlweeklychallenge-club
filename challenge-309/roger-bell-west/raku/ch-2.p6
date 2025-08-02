#! /usr/bin/raku

use Test;

plan 2;

is(mindiff([1, 5, 8, 9]), 1, 'example 1');
is(mindiff([9, 4, 1, 7]), 2, 'example 2');

sub mindiff(@a) {
    my $md = 0;
    my $n = False;
    for 0 .. @a.end - 1 -> $i {
        for $i + 1 .. @a.end -> $j {
            my $diff = abs(@a[$i] - @a[$j]);
            if (!$n || $diff < $md) {
                $md = $diff;
                $n = True;
            }
        }
    }
    $md;
}
