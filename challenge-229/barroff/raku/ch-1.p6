#!/usr/bin/env raku

use v6.d;

sub is-lexicographic(Str:D $string --> Bool:D) {
    my Str $sorted-string = join('', sort(split('', $string)));
    $sorted-string eq $string or flip($sorted-string) eq $string;
}

multi sub lexicographic-order(Str:D @strings --> Int:D) {
    (grep { not is-lexicographic($_) }, @strings).elems;
}

multi sub lexicographic-order(*@words where @words.elems ≥ 1 --> Int:D) {
    (grep { not is-lexicographic(Str($_)) }, @words).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is lexicographic-order(Array[Str:D].new(("abc", "bce", "cae"))), 1,
        'works for ("abc", "bce", "cae")';
    is lexicographic-order(Array[Str:D].new(("yxz", "cba", "mon"))), 2,
        'works for ("yxz", "cba", "mon")';
}


#| Take user provided list like Perl Rust Raku
multi sub MAIN(*@words where @words.elems ≥ 1) {
    my Str @str-words = @words;
    say lexicographic-order(@str-words);
}
