#! /usr/bin/raku

use Test;

plan 3;

is(reverseletters('p-er?l'), 'l-re?p', 'example 1');
is(reverseletters('wee-k!L-y'), 'yLk-e!e-w', 'example 2');
is(reverseletters('_c-!h_all-en!g_e'), '_e-!g_nel-la!h_c', 'example 3');

sub reverseletters($a) {
    my @vout = ' ' xx $a.chars;
    my @letterslots;
    my @letters;
    for $a.comb.kv -> $i, $c {
        if ($c ~~ /<[A..Za..z]>/) {
            @letterslots.push($i);
            @letters.push($c);
        } else {
            @vout[$i] = $c;
        }
    }
    for @letterslots -> $i {
        @vout[$i] = @letters.pop;
    }
    @vout.join('');
}
