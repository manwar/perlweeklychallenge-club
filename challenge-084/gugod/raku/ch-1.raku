#!/usr/bin/env raku

sub reverse-integer (Int $n) {
    my $o = ($n < 0 ?? -1 !! 1) * flip abs $n;
    return (-2³¹ ≤ $o < 2³¹) ?? $o !! 0;
}

sub MAIN (Int $n) {
    say reverse-integer($n);
}
