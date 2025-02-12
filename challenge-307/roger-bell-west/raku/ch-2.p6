#! /usr/bin/raku

use Test;

plan 2;

is(findanagrams(['acca', 'dog', 'god', 'perl', 'repl']), 3, 'example 1');
is(findanagrams(['abba', 'baba', 'aabb', 'ab', 'ab']), 2, 'example 2');

sub findanagrams(@a) {
    my @b;
    for @a -> $s {
        @b.push($s.comb.sort.join(""));
    }
    my $out = 1;
    for 1 .. @b.end -> $i {
        if (@b[$i - 1] ne @b[$i]) {
            $out++;
        }
    }
    $out;
}
