#! /usr/bin/raku

use Test;

plan 5;

is(reversedegree('z'), 1, 'example 1');
is(reversedegree('a'), 26, 'example 2');
is(reversedegree('bbc'), 147, 'example 3');
is(reversedegree('racecar'), 560, 'example 4');
is(reversedegree('zyx'), 14, 'example 5');

sub reversedegree($a) {
    my $t = 0;
    my $z0 = 'z'.ord + 1;
    for $a.comb.kv -> $i, $c {
        $t += ($z0 - $c.ord) * (1 + $i);
    }
    $t;
}
