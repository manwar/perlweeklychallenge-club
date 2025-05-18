#!/usr/bin/env raku

use v6.d;

sub backspace-compare(Str $str1, Str $str2 --> Bool) {
    $str1.trans('#' => '') eq $str2.trans('#' => '');
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is backspace-compare("ab#c", "ab#c"), True, 'works for "ab#c"';
    is backspace-compare("ab##", "a#b#"), True, 'works for "ab##" and "a#b#';
    is backspace-compare("a#b", "c"), False, 'works for "a#b" and "c"';
}

#| Take user provided strings like 'ab#c' 'ab#c'
multi sub MAIN(Str $str1, Str $str2) {
    say backspace-compare($str1, $str2);
}
