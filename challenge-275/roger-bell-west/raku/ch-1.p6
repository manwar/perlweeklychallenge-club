#! /usr/bin/raku

use Test;

plan 3;

is(brokenkeys('Perl Weekly Challenge', ['l', 'a']), 0, 'example 1');
is(brokenkeys('Perl and Raku', ['a']), 1, 'example 2');
is(brokenkeys('Well done Team PWC', ['l', 'o']), 2, 'example 3');

sub brokenkeys($a, @k) {
    my $out = 0;
    my %failset = Set(@k.map({$_.lc}));
    for $a.split(" ") -> $word {
        my %wordset = Set($word.lc.comb);
        if ((%wordset (&) %failset).elems == 0) {
            $out++;
        }
    }
    return $out;
}
