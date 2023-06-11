#!/usr/bin/env raku

use v6.d;

sub common-characters(Str:D @words --> List) {
    List(sort(keys([∩] map({ $_.lc.comb.Set }, @words))));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is common-characters(Array[Str:D].new(("Perl", "Rust", "Raku"))),
        ('r'), 'works for ("Perl", "Rust", "Raku")';
    is common-characters(Array[Str:D].new(("love", "live", "leave"))),
        ('e', 'l', 'v'), 'works for ("love", "live", "leave")';
}

#| Take user provided list like Perl Rust Raku
multi sub MAIN(*@words where @words.elems ≥ 1) {
    my Str @str-words = @words;
    say common-characters(@str-words);
}
