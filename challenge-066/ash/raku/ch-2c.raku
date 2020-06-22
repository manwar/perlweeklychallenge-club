#!/usr/bin/env raku

my $n = 81;
# my $n = 45;

say (gather {
    for [X] (1..$n.sqrt) xx 2 -> ($x, $y) {
        take "$x^$y" if $n == $x ** $y;
    }
} || 0).join(', ');
