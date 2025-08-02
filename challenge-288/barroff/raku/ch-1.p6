#!/usr/bin/env raku

use v6.d;

sub is-palindrome($word --> Bool) {
    $word eq $word.flip;
}

sub find-palindrome($str, &mod) {
    my $mod-str = &mod($str);
    return $mod-str if is-palindrome($mod-str);
    return find-palindrome($mod-str, &mod);
}

sub closest-palindrome(Str $str --> Str) {
    my &dec-one = -> $x { $x - 1 };
    my &inc-one = -> $x { $x + 1 };
    my $lower-palindrome = find-palindrome($str, &dec-one);
    my $upper-palindrome = find-palindrome($str, &inc-one);

    $str - $lower-palindrome <= $upper-palindrome - $str
        ?? Str($lower-palindrome)
        !! Str($upper-palindrome);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is closest-palindrome("123"), "121", 'works for "123"';
    is closest-palindrome("2"), "1", 'works for "2"';
    is closest-palindrome("1400"), "1441", 'works for "1400"';
    is closest-palindrome("1001"), "999", 'works for "1001"';
}

#| Take user provided string like "1400"
multi sub MAIN(Str $str) {
    say closest-palindrome($str);
}
