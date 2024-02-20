#!/usr/bin/env raku

use v6.d;

sub maximum-pairs(@words --> Int:D) {
   grep({ $_[0] eq $_[1].flip }, combinations(@words, 2)).elems; 
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is maximum-pairs(["ab", "de", "ed", "bc"]), 1,
        'works for ("ab", "de", "ed", "bc")';
    is maximum-pairs(["aa", "ba", "cd", "ed"]), 0,
        'works for ("aa", "ba", "cd", "ed")';
    is maximum-pairs(["uv", "qp", "st", "vu", "mn", "pq"]), 2,
        'works for ("uv", "qp", "st", "vu", "mn", "pq")';
}

#| Take user provided word like aba
multi sub MAIN(@*words) {
    say maximum-pairs(@*words);
}
