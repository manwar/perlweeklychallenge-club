#! /usr/bin/raku

use Test;

plan 5;

is(reverseprefix('programming', 'g'), 'gorpramming', 'example 1');
is(reverseprefix('hello', 'h'), 'hello', 'example 2');
is(reverseprefix('abcdefghij', 'h'), 'hgfedcbaij', 'example 3');
is(reverseprefix('reverse', 's'), 'srevere', 'example 4');
is(reverseprefix('perl', 'r'), 'repl', 'example 5');


sub reverseprefix($a, $f) {
    my @c = $a.comb;
    my $p = index($a, $f);
    with ($p) {
        my @jr = @c[0 .. $p];
        @jr = @jr.reverse;
        splice @c, 0, $p + 1, @jr;
    }
    join('', @c);
}
