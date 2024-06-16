#!/usr/bin/env raku

use v6.d;

sub b-after-a(Str $str where $str ~~ /^<[ab]>*$/ --> Bool) {
    return $str ~~ /^a*b+$/ ?? True !! False;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is b-after-a("aabb"), True, 'works for "aabb"';
    is b-after-a("abab"), False, 'works for "abab"';
    is b-after-a("aaa"), False, 'works for "aaa"';
    is b-after-a("bbb"), True, 'works for "bbb"';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Str $str) {
    say b-after-a($str);
}
