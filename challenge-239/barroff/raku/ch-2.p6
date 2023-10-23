#!/usr/bin/env raku

use v6.d;

sub consistent-strings(Str:D $allowed, @str --> Int:D) {
    my $allowed-chars = Set($allowed.comb);
    return grep({ Set($_.comb) ⊆ $allowed-chars }, @str).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is consistent-strings("ab", ("ad", "bd", "aaab", "baa", "badab")), 2,
        'works for ("ab", ("ad", "bd", "aaab", "baa", "badab"))';
    is consistent-strings("abc", ("a", "b", "c", "ab", "ac", "bc", "abc")), 7,
        'works for ("abc", ("a", "b", "c", "ab", "ac", "bc", "abc"))';
    is consistent-strings("cad", ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")),
        4,
        'works for ("cad", ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"))';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(Str:D $allowed, *@words where @words.elems ≥ 1) {
    my Str @swords = @words;
    say consistent-strings($allowed, @swords);
}
