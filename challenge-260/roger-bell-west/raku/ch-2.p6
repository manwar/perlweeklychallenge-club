#! /usr/bin/raku

use Test;

plan 3;

is(dictionaryrank('CAT'), 3, 'example 1');
is(dictionaryrank('GOOGLE'), 88, 'example 2');
is(dictionaryrank('SECRET'), 255, 'example 3');

sub dictionaryrank($a) {
    my @c = $a.comb;
    my %d = SetHash.new;
    for @c.permutations -> @o {
        %d{@o.join("")}++;
    }
    my @dd = %d.keys.sort;
    for 0 .. @dd.end -> $i {
        if (@dd[$i] eq $a) {
            return $i + 1;
        }
    }
    return 0;
}
