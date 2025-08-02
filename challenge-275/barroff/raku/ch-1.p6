#!/usr/bin/env raku

use v6.d;

sub broken-keys(Str $sentence, @keys --> Int) {
    my $key-set = Set(map(&lc,@keys));
    grep({ $key-set (&) Set($_.comb) == ∅ }, $sentence.lc.words).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 4;

    is broken-keys("Perl Weekly Challenge", ['l', 'a']), 0,
        'works for "Perl Weekly Challenge"';
    is broken-keys("Perl and Raku", ['a']), 1, 'works for "Perl and Raku"';
    is broken-keys("Well done Team PWC", ['l', 'o']), 2,
        'works for "Well done Team PWC"';
    is broken-keys("The joys of polyglottism", ['T']), 2,
        'works for "The joys of polyglottism"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(Str $sentence, *@keys) {
    say broken-keys($sentence, @keys);
}
