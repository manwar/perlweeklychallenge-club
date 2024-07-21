#!/usr/bin/env raku

use v6.d;

sub reverse-word(Str $word, Str $char --> Str) {
    return $word unless $word.contains($char);
    $word ~~ /
        ^
        (\w*? "$char")
        (\w*)
    /;
    sort($0.comb).join ~ $1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is reverse-word("challenge", "e"), "acehllnge", 'works for "challenge" and "e"';
    is reverse-word("programming", "a"), "agoprrmming",
        'works for "programming" and "a"';
    is reverse-word("champion", "b"), "champion", 'works for "champion" and "b"';
}

#| Take user provided strings like challenge e
multi sub MAIN(Str $word, Str $char where chars($char) == 1) {
    say reverse-word($word, $char);
}
