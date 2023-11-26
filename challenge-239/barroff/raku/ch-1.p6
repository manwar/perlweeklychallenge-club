#!/usr/bin/env raku

use v6.d;

sub same-string(@arr1, @arr2) {
    [~](@arr1) eq [~](@arr2);
}

#| Run test cases
multi sub MAIN() {
    use Test;
    plan 3;

    is same-string(("ab", "c"), ("a", "bc")), True,
        'works for (("ab", "c"), ("a", "bc"))';
    is same-string(("ab", "c"), ("ac", "b")), False,
        'works for (("ab", "c"), ("ac", "b"))';
    is same-string(("ab", "cd", "e"), ("abcde",)), True,
        'works for (("ab", "cd", "e"), ("abcde",))';
}
