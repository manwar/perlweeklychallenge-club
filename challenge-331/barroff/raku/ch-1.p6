#!/usr/bin/env raku

use v6.d;

sub last-word(Str $str --> Int) {
    ($str.words)[* - 1].chars;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is last-word("The Weekly Challenge"), 9, 'works for "The Weekly Challenge"';
    is last-word("   Hello   World    "), 5, 'works for "   Hello   World    "';
    is last-word("Let's begin the fun"), 3, 'works for "Let\'s begin the fun"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(*@words) {
    say last-word(@words.join(' '));
}
