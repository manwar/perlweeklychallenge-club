#! /usr/bin/raku

use Test;

plan 3;

is(incrementdecrement(['--x', 'x++', 'x++']), 1, 'example 1');
is(incrementdecrement(['x++', '++x', 'x++']), 3, 'example 2');
is(incrementdecrement(['x++', '++x', '--x', 'x--']), 0, 'example 3');

sub incrementdecrement(@operations) {
    my $p = 0;
    for @operations -> $s {
        if ($s ~~ /\+/) {
            $p++;
        } else {
            $p--;
        }
    }
    $p;
}
