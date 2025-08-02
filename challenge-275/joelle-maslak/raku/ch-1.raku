#!/usr/bin/env raku
use v6.d;

sub MAIN($sentence, $badkeys) {
    say $sentence.fc.words.grep({!(.comb ∩ $badkeys.fc.comb)}).elems;
}
