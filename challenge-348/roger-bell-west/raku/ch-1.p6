#! /usr/bin/raku

use Test;

plan 5;

is(stringalike('textbook'), False, 'example 1');
is(stringalike('book'), True, 'example 2');
is(stringalike('AbCdEfGh'), True, 'example 3');
is(stringalike('rhythmmyth'), False, 'example 4');
is(stringalike('UmpireeAudio'), False, 'example 5');

sub stringalike($a) {
    if ($a.chars % 2 == 1) {
        return False;
    }
    my $vt = 0;
    my $mode = 1;
    my $av = False;
    for $a.lc.comb.kv -> $i, $c {
        if ($i * 2 == $a.chars) {
            $mode = -1;
        }
        if ($c ~~ /<[aeiou]>/) {
            $av = True;
            $vt += $mode;
        }
    }
    $av && ($vt == 0);
}
