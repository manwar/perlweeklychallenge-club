#! /usr/bin/raku

use Test;

plan 5;

is(championteam([[0, 1, 1], [0, 0, 1], [0, 0, 0]]), 0, 'example 1');
is(championteam([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]), 3, 'example 2');
is(championteam([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]), 0, 'example 3');
is(championteam([[0, 1, 1], [0, 0, 0], [0, 1, 0]]), 0, 'example 4');
is(championteam([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]), 2, 'example 5');

sub championteam(@a) {
    my $maxw = 0;
    my @teamw;
    for @a.kv -> $i, @w {
        my $wins = sum(@w);
        if ($wins > $maxw) {
            @teamw = [];
            $maxw = $wins;
        }
        if ($wins == $maxw) {
            @teamw.push($i);
        }
    }
    if (@teamw.elems == 1) {
        return @teamw[0];
    }
    my $bestt = @teamw[0];
    for @teamw -> $rt {
        if (@a[$rt][$bestt] == 1) {
            $bestt = $rt;
        }
    }
    $bestt;
}
