#!/usr/bin/env raku

use v6.d;

sub word-count(@list --> Int) {
    grep({ $_.lc ~~ / ^ (<[aeiou]><alpha>*|<alpha>*<[aeiou]>) $ / }, @list).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is word-count(["unicode", "xml", "raku", "perl"]), 2,
        'works for ["unicode", "xml", "raku", "perl"]';
    is word-count(["the", "weekly", "challenge"]), 2,
        'works for ["the", "weekly", "challenge"]';
    is word-count(["perl", "python", "postgres"]), 0,
        'works for ["perl", "python", "postgres"]';
}

#| Take user provided words like "perl", "python", "postgres"
multi sub MAIN(*@list) {
    say word-count(@list);
}
