#!/usr/bin/env raku

use v6.d;

sub dictionary-rank(Str:D $word --> Int:D) {
    my @words = $word.comb.permutations.map({ $_.join }).unique.sort;
    return 1 + @words.first: * eq $word, :k;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is dictionary-rank("CAT"), 3, 'works for "CAT"';
    is dictionary-rank("GOOGLE"), 88, 'works for "GOOGLE"';
    is dictionary-rank("SECRET"), 255, 'works for "SECRET"';
}

#| Take user provided words like CAT
multi sub MAIN(Str:D $word) {
    say dictionary-rank($word);
}
