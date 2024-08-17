#! /usr/bin/raku

use Test;

plan 3;

is(splitstring('perl'), False, 'example 1');
is(splitstring('book'), True, 'example 2');
is(splitstring('goodmorning'), True, 'example 3');

sub splitstring($a) {
    my $n = 0;
    for $a.lc.comb -> $cc {
        if ($cc ~~ /<[aeiou]>/) {
            $n++;
        }
    }
    return $n % 2 == 0;
}
