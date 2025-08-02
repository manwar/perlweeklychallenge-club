#! /usr/bin/raku

use Test;

plan 3;

is(reverseword('challenge', 'e'), 'acehllnge', 'example 1');
is(reverseword('programming', 'a'), 'agoprrmming', 'example 2');
is(reverseword('champion', 'b'), 'champion', 'example 3');

sub reverseword($a, $c) {
    with $a.index($c) -> $m {
        my @aa = $a.substr(0, $m+1).comb;
        @aa = sort @aa;
        @aa.push($a.substr($m+1).comb.Slip);
        return @aa.join('');
    } else {
        return $a;
    }
}
