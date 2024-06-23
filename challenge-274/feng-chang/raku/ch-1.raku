#!/bin/env raku

unit sub MAIN(Str:D $snt);

put $snt.words.map({
    my ($h, $t) = .substr(0, 1), .substr(1);
    ($h.&is-vowel ?? $_ !! $t ~ $h) ~ 'ma' ~ 'a' x ++$
}).join(' ');

my method is-vowel(Str:D $c : --> Bool:D) {
    so $c eq <a e i o u A E I O U>.any
}
