#! /usr/bin/raku

use Test;

plan 5;

is(secondlargestdigit('aaaaa77777'), -1, 'example 1');
is(secondlargestdigit('abcde'), -1, 'example 2');
is(secondlargestdigit('9zero8eight7seven9'), 8, 'example 3');
is(secondlargestdigit('xyz9876543210'), 8, 'example 4');
is(secondlargestdigit('4abc4def2ghi8jkl2'), 4, 'example 5');

sub secondlargestdigit($a) {
    my %p = Set.new($a.comb.grep({$_ ge '0' && $_ le '9'}));
    my @k = %p.keys.sort.reverse;
    if (@k.elems > 1) {
        @k[1];
    } else {
        -1;
    }
}
