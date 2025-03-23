#!/usr/bin/env raku

use v6.d;

sub reverse-letters(Str $str --> Str) {
    my @characters = grep({ $_ ~~ m:i/ <[a..z]> / }, $str.comb);
    map({ $_ ~~ m:i/ <[a..z]> / ?? @characters.pop !! $_ }, $str.comb).join;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is reverse-letters("p-er?l"), "l-re?p", 'works for "p-er?l"';
    is reverse-letters("wee-k!L-y"), "yLk-e!e-w", 'works for "wee-k!L-y"';
    is reverse-letters("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c",
        'works for "_c-!h_all-en!g_e"';
}

#| Take user provided string like "_c-!h_all-en!g_e"
multi sub MAIN(Str $str) {
    say reverse-letters($str);
}
