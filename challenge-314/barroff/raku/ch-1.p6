#!/usr/bin/env raku

use v6.d;

sub equal-strings(*@str --> Int) {
    my &compare-chars = -> $x {
        Set(map({ $_.comb[$x] }, @str)).elems == 1;
    };
    my Int $shortest-string = min(map({ $_.chars }, @str)) - 1;
    my @res = map({ &compare-chars($_) }, 0..$shortest-string);
    return -1 unless @res[0];
    my Int $same-chars = 1;
    for 1..$shortest-string -> $x {
        @res[$x] ?? $same-chars++ !! last;
    }
    return sum(map({ $_.chars - $same-chars }, @str));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is equal-strings("abc", "abb", "ab"), 2, 'works for "abc", "abb", "ab"';
    is equal-strings("ayz", "cyz", "xyz"), -1, 'works for "ayz", "cyz", "xyz"';
    is equal-strings("yza", "yzb", "yzc"), 3, 'works for "yza", "yzb", "yzc"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(*@keys where @keys.elems > 1) {
    say equal-strings(@keys);
}
