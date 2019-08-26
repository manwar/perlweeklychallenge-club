#!/usr/bin/perl6

for (2 .. *) -> $n {
    my $p = 3 * 2 ** ($n - 1) - 1;
    my $q = 3 * 2 ** ($n) - 1;
    my $r = 9 * 2 ** (2 * $n - 1) - 1;

    if ($p, $q, $r).all.is-prime() {
        say '(', (2 ** $n) * $p * $q, ', ',  (2 ** $n) * $r, ')';
        last;
    }
}