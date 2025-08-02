#!/usr/bin/env raku

use v6.d;

sub split-string(Str $str--> Bool) {
    grep({ /<[aeiou]>/ }, $str.comb).elems mod 2 == 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is split-string("perl"), False, 'works for "perl"';
    is split-string("book"), True, 'works for "book"';
    is split-string("good morning"), True, 'works for "good morning"';
}

#| Take user provided string like "Perl Weekly Challenge"
multi sub MAIN(Str $str) {
    say split-string($str);
}
