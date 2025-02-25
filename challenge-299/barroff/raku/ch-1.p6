#!/usr/bin/env raku

use v6.d;

sub replace-words(Str $sentence, @words --> Str) {
    sub cw(Str $s) {
        my @matching = grep({ $s.starts-with($_) }, @words);
        return @matching ?? @matching[0] !! $s;
    }

    return map(&cw, $sentence.words).join(' ');
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is replace-words("the cattle was rattle by the battery",
        ["cat", "bat", "rat"]), "the cat was rat by the bat",
        'works for "the cattle was rattle by the battery"';
    is replace-words("aab aac and cac bab", ["a", "b", "c"]), "a a a c b",
        'works for "aab aac and cac bab"';
    is replace-words("the manager was hit by a biker", ["man", "bike"]),
        "the man was hit by a bike",
        'works for "the manager was hit by a biker"';
}

#| Take user provided strings like "the cattle was rattle by the battery" cat bat rat
multi sub MAIN(Str $sentence, *@words) {
    say replace-words($sentence, @words);
}

