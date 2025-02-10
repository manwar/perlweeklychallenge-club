#!/usr/bin/env raku

use v6.d;

sub find-anagrams(@words --> Int) {
    grep(
        { @words[$_].comb.sort ≠ @words[$_ + 1].comb.sort },
        0..@words.elems - 2
    ).elems + 1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is find-anagrams(["acca", "dog", "god", "perl", "repl"]), 3,
        'works for ["acca", "dog", "god", "perl", "repl"]';
    is find-anagrams(["abba", "baba", "aabb", "ab", "ab"]), 2,
        'works for ["abba", "baba", "aabb", "ab", "ab"]';
}

#| Take user provided strings like the cattle was rattle by the battery cat bat rat
multi sub MAIN(*@words) {
    say find-anagrams(@words);
}
