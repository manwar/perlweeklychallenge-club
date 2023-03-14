#! /usr/bin/raku

use Test;

plan 2;

is-deeply(keyboardword(['Hello', 'Alaska', 'Dad', 'Peace']), ['Alaska', 'Dad'], 'example 1');
is-deeply(keyboardword(['OMG', 'Bye']), [], 'example 2');

sub keyboardword(@wl) {
    return [grep rx:i/^(<[qwertyuiop]>+|<[asdfghjkl]>+|<[zxcvbnm]>+)$/, @wl];
}
