#! /usr/bin/raku

use Test;

plan 3;

is(twiceappearance('acbddbca'), 'd', 'example 1');
is(twiceappearance('abccd'), 'c', 'example 2');
is(twiceappearance('abcdabbb'), 'a', 'example 3');

sub twiceappearance($a) {
    my %m = SetHash.new;
    for $a.comb -> $c {
        if (%m{$c}:exists) {
            return $c
        }
        %m{$c}++;
    }
    return 'x';
}
