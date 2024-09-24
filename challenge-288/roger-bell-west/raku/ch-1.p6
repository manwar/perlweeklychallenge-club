#! /usr/bin/raku

use Test;

plan 4;

is(closestpalindrome('123'), '121', 'example 1');
is(closestpalindrome('2'), '1', 'example 2');
is(closestpalindrome('1400'), '1441', 'example 3');
is(closestpalindrome('1000'), '999', 'example 4');

sub closestpalindrome($a) {
    my $delta = -1;
    while (1) {
        my $q = ($a + $delta);
        if ($q eq $q.flip) {
            return $q;
        }
        $delta = -$delta;
        if ($delta < 0) {
            $delta -= 1;
        }
    }
}
