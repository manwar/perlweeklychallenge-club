#!/usr/bin/env raku

sub MAIN (Int $M, Int $N) {
    my ($a, $b) = ($M, $N).sort;
    say common-factors($a, $b);
}

sub common-factors (Int $a, Int $b) {
    (1, 2..$a/2, $a).flat.grep(-> $n { 0 == $a % $n == $b % $n });
}
