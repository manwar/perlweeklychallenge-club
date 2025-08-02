#!/usr/bin/env raku

use v6.d;

sub merge-strings(Str:D $str1, Str:D $str2 --> Str:D) {
    my Int:D $c1 = $str1.chars;
    my Int:D $c2 = $str2.chars;
    my @characters1 = $str1.comb;
    my @characters2 = $str2.comb;
    map(
        { ($_ ≥ $c1 ?? "" !! @characters1[$_]) ~ 
        ($_ ≥ $c2 ?? "" !! @characters2[$_])
    }, 0..max($c1, $c2) - 1
    ).join("");
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is merge-strings("abcd", "1234"), "a1b2c3d4", 'works for ("abcd", "1234")';
    is merge-strings("abc", "12345"), "a1b2c345", 'works for ("abc", "12345")';
    is merge-strings("abcde", "123"), "a1b2c3de", 'works for ("abcd𝑒", "123")';
}

#| Take user provided words like aba 1234
multi sub MAIN(Str:D $str1, Str:D $str2) {
    say merge-strings($str1, $str2);
}
