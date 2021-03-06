#!/usr/bin/env raku

sub hash-counting-string ($n) {
    "$n#", { $n - .chars ~ "#" ~ $_ } ... *.chars ≥ $n
    andthen .tail
    andthen .subst: /^1 <?before '#' > /, :d;
}

multi MAIN (Bool :$test!) {
    use Test;
    is hash-counting-string(12).chars, 12;
    is hash-counting-string( 1),        '#';
    is hash-counting-string( 2),        '2#';
    is hash-counting-string( 3),        '#3#';
    is hash-counting-string(10),        '#3#5#7#10#';
    is hash-counting-string(14),        '2#4#6#8#11#14#';
    done-testing;
}

multi MAIN (Int $n) {
    say hash-counting-string( $n )
}
