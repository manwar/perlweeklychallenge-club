#! /usr/bin/raku

use Test;

plan 5;

is(alphabetindexdigitsum('abc', 1), 6, 'example 1');
is(alphabetindexdigitsum('az', 2), 9, 'example 2');
is(alphabetindexdigitsum('cat', 1), 6, 'example 3');
is(alphabetindexdigitsum('dog', 2), 8, 'example 4');
is(alphabetindexdigitsum('perl', 3), 6, 'example 5');

sub alphabetindexdigitsum($a, $k) {
    my $st = "";
    for $a.comb -> $c {
        $st ~= ($c.ord - 96)
    }
    my $v = 0 + $st;
    for 1 .. $k {
        my $j = 0;
        while ($v > 0) {
            $j += $v % 10;
            $v div= 10;
        }
        $v = $j;
    }
    $v;
}
