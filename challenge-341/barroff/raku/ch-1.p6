#!/usr/bin/env raku

use v6.d;

sub broken-keyboard(Str $str, @keys --> Int) {
    my $key-set = Set(map(&lc,@keys));
    grep({ $key-set (&) Set($_.comb) == ∅ }, $str.lc.words).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is broken-keyboard("Hello World", ['d']), 1, 'works for "Hello World"';
    is broken-keyboard("apple banana cherry", ['a', 'e']), 0,
        'works for "apple banana cherry"';
    is broken-keyboard("Coding is fun", []), 3, 'works for "Coding is fun"';
    is broken-keyboard("The Weekly Challenge", ['a', 'b']), 2,
        'works for "The Weekly Challenge"';
    is broken-keyboard("Perl and Python", ['p']), 1,
        'works for "Perl and Python"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(Str $sentence, *@keys) {
    say broken-keyboard($sentence, @keys);
}
