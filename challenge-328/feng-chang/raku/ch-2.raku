#!/bin/env raku

unit sub MAIN(Str:D $s is copy where *.match: /^ <[a..zA..Z]>+ $/);

while $s.subst-mutate(/(.)(.) <?{ is-upper-lower(~$0, ~$1) }>/, '') { }
put $s;

sub is-upper-lower(Str:D $c1, Str:D $c2 --> Bool:D) {
    abs($c1.ord - $c2.ord) == 'a'.ord - 'A'.ord
}
