#!/usr/bin/env raku

use v6.d;

sub percentage-of-character(Str $str, Str $char --> Int) {
    return 0 unless $str.contains($char);
    ceiling(100 * Bag($str.comb){$char} ÷ $str.chars)
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 6;

    is percentage-of-character("perl", "e"), 25, 'works for "perl" and "e"';
    is percentage-of-character("java", "a"), 50, 'works for "perl" and "a"';
    is percentage-of-character("python", "m"), 0, 'works for "python" and "m"';
    is percentage-of-character("ada", "a"), 67, 'works for "ada" and "a"';
    is percentage-of-character("ballerina", "l"), 23, 'works for "ballerina" and "l"';
    is percentage-of-character("analitik", "k"), 13, 'works for "analitik" and "k"';
}

#| Take user provided number like 10 1 111 24 1000
multi sub MAIN(Str $str, Str $char) {
    say percentage-of-character($str, $char);
}
