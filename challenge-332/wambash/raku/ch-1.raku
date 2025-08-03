#!/usr/bin/env raku

sub binary-date ($date) {
    $date
    andthen .subst: /\d+/, {.Int.base: 2 }, :g
}

multi MAIN (Bool :test($)!) {
    use Test;
    is binary-date('2025-07-26'), '11111101001-111-11010';
    is binary-date('2000-02-02'), '11111010000-10-10';
    is binary-date('2024-12-31'), '11111101000-1100-11111';
    done-testing;
}

multi MAIN ($date) {
    say binary-date $date;
}
