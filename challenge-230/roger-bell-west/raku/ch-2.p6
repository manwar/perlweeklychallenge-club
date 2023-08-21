#! /usr/bin/raku

use Test;

plan 2;

is(prefixwords(['pay', 'attention', 'practice', 'attend'], 'at'), 2, 'example 1');
is(prefixwords(['janet', 'julia', 'java', 'javascript'], 'ja'), 3, 'example 2');

sub prefixwords(@s, $p) {
    my $r = 0;
    for @s -> $w {
        with $w.index($p) -> $i {
            if ($i == 0) {
                $r++;
            }
        }
    }
    return $r;
}
