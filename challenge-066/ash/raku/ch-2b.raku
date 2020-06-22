#!/usr/bin/env raku

my $n = 81;
# my $n = 45;

for [X] (1..$n.sqrt) xx 2 -> ($x, $y) {
    say "$x^$y" if $n == $x ** $y;
}
