#!/usr/bin/env raku

use v6.d;

sub common-characters(@words --> Seq) {
    (reduce { $^a ∩ $^b }, @words.map({ $_.comb.Bag })).kxxv
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is common-characters(["bella", "label", "roller"]).sort, ["e", "l", "l"],
        'works for "bella", "label", "roller"';
    is common-characters(["cool", "lock", "cook"]).sort, ["c", "o"],
        'works for "cool", "lock", "cook"';
    is common-characters(["hello", "world", "pole"]).sort, ["l", "o"],
        'works for "hello", "world", "pole"';
    is common-characters(["abc", "def", "ghi"]).sort, [],
        'works for "abc", "def", "ghi"';
    is common-characters(["aab", "aac", "aaa"]).sort, ["a", "a"],
        'works for "aab", "aac", "aaa"';
}

#| Take user provided words like Perl Weekly Challenge
multi sub MAIN(*@words) {
    say common-characters(@words);
}
