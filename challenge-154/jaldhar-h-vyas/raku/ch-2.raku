#!/usr/bin/raku

sub MAIN() {
    my @padovans = 1, 1, 1, -> $a, $b, $c { $a + $b } ... *;
    @padovans.grep({ .is-prime; }).unique[^10].join(q{, }).say;
}