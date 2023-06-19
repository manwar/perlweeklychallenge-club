#!/usr/bin/env raku

use v6.d;

sub good-strings(Str:D @words, Str:D $chars --> Int) {
    my $chars-bag = Bag($chars.comb);
    my Str @gs = grep( {Bag($_.comb) ⊆ $chars-bag}, @words );
    return [+] map({ $_.chars }, @gs)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is good-strings(Array[Str:D].new("cat", "bt", "hat", "tree"), 'atach'), 6,
        'works for ("cat", "bt", "hat", "tree")';
    is good-strings(Array[Str:D].new("hello", "world", "challenge"), 'welldonehopper'), 10,
        'works for ("hello", "world", "challenge")';
}

#| Take user provided list like 1 17 8
multi sub MAIN(*@words where @words.elems ≥ 1) {
    my Str @strings = @words;
    say good-strings(@strings);
}
