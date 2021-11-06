#!/usr/bin/env raku


sub is-Lychrel-number ($n) {
    $n, {$_ + .flip} ... * >= 10_000_000
    andthen .head: 500
    andthen not .first: {$_ eq .flip}, :p
}

multi MAIN ($n) {
    say +is-Lychrel-number $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    nok is-Lychrel-number(56);
    nok is-Lychrel-number(57);
    nok is-Lychrel-number(59);
    ok is-Lychrel-number(196);
    done-testing;
}
