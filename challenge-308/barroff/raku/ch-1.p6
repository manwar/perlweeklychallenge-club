#!/usr/bin/env raku

use v6.d;

sub count-common(@str1, @str2 --> Int) {
    (Set(@str1) ∩ Set(@str2)).elems;
}

#| Run test cases
sub MAIN('test') {
    use Test;
    plan 3;

    is count-common(
        ["perl", "weekly", "challenge"],
        ["raku", "weekly", "challenge"]
    ), 2, 'works for example 1';
    is count-common(["perl", "raku", "python"], ["python", "java"]), 1,
        'works for example 2';
    is count-common(["guest", "contribution"], ["fun", "weekly", "challenge"]),
        0, 'works for example 3';
}
