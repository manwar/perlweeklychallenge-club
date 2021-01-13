#!/bin/env raku

sub MAIN(Str:D $s) {
    say $s.words.head(*-1).tail(*-1).join.chars;
}
