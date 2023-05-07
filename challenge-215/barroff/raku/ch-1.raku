#!/usr/bin/env raku

use v6.d;

sub is-alphabetic(Str $s --> Bool) {
    $s eq $s.comb.sort.join;
}

sub odd-one-out(Str @words where @words[0].chars == (map(&chars, @words)).all --> Int) {
    my @sorted-words = @words.grep: &is-alphabetic;
    return @words.elems - @sorted-words.elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is odd-one-out(Array[Str].new('abc', 'xyz', 'tsu')), 1, "works for ('abc', 'xyz', 'tsu')";
    is odd-one-out(Array[Str].new('rat', 'cab', 'dad')), 3, "works for ('rat', 'cab', 'dad')";
    is odd-one-out(Array[Str].new('x', 'y', 'z')), 0, "works for ('x', 'y', 'z')";
}

#| Take user provided list like x y z
multi sub MAIN(*@words where @words.elems ≥ 1 && @words[0].chars == (map(&chars, @words)).all) {
    my Str @strings = @words;
    say odd-one-out(@strings);
}
