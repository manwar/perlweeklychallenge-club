#!/usr/bin/env raku

use v6.d;

sub duplicate-removal(Str $str --> Str) {
    my Str $s = $str;
    while $s ~~ m/ (<:Ll>) {} :my $c=$0; $c / {
        $s ~~ s/ (<:Ll>) {} :my $c=$0; "$c" //;
    };
    return $s;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is duplicate-removal("abbaca"), "ca", 'works for "abbaca"';
    is duplicate-removal("azxxzy"), "ay", 'works for "azxxzy"';
    is duplicate-removal("aaaaaaaa"), "", 'works for "aaaaaaaa"';
    is duplicate-removal("aabccba"), "a", 'works for "aabccba"';
    is duplicate-removal("abcddcba"), "", 'works for "abcddcba"';
}

#| Take user provided string like "abbaca"
multi sub MAIN(Str $str) {
    say duplicate-removal($str);
}
