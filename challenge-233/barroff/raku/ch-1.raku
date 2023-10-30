#!/usr/bin/env raku

use v6.d;

sub are-similar(Str:D $word1, Str:D $word2 --> Bool:D) {
    my $characters1 = Set($word1.comb);
    my $characters2 = Set($word2.comb);
    $characters1 (==) $characters2;
}

sub similar-words(*@words --> Int:D) {
    (grep { are-similar($_[0], $_[1]) }, combinations(@words, 2)).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is similar-words("aba", "aabb", "abcd", "bac", "aabc"), 2,
        'works for ("aba", "aabb", "abcd", "bac", "aabc")';
    is similar-words("aabb", "ab", "ba"), 3,
        'works for ("aabb", "ab", "ba")';
    is similar-words("nba", "cba", "dba"), 0,
        'works for ("nba", "cba", "dba")';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(*@words where @words.elems ≥ 1) {
    my Str @swords = @words;
    say similar-words(@swords);
}
