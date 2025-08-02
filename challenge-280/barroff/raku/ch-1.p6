#!/usr/bin/env raku

use v6.d;

sub twice-appearance(Str $str --> Str) {
    my %key-dict;
    my $res = map({ %key-dict{$_} ?? return $_ !! %key-dict{$_} = 1 }, $str.comb);
    dd $res;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is twice-appearance("acbddbca"), "d", 'works for "acbddbca"';
    is twice-appearance("abccd"), "c", 'works for "abccd"';
    is twice-appearance("abcdabbb"), "a", 'works for "abcdabbb"';
}

#| Take user provided string like "bcdabbb"
multi sub MAIN(Str $str where $str ~ /^<[a..z]>$/) {
    say twice-appearance($str);
}
