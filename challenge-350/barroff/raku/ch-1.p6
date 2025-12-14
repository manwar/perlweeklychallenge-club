#!/usr/bin/env raku

use v6.d;

sub is-good-substrings(Str $str --> Bool) {
    $str.comb.Set.elems == $str.chars;
}

sub good-substrings(Str $str --> Int) {
    grep({ is-good-substrings($str.substr($_, 3)) }, 0..$str.chars - 3).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is good-substrings("abcaefg"), 5, 'works for "abcaefg"';
    is good-substrings("xyzzabc"), 3, 'works for "xyzzabc"';
    is good-substrings("aababc"),  1, 'works for "aababc"';
    is good-substrings("qwerty"),  4, 'works for "qwerty"';
    is good-substrings("zzzaaa"),  0, 'works for "zzzaaa"';
}

#| Take user provided string like "PerlWeeklyChallenge"
multi sub MAIN(Str $str) {
    say good-substrings($str);
}
