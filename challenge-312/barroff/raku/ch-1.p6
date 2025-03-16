#!/usr/bin/env raku

use v6.d;

sub character-diff(Str $a, Str $b --> Int) {
    my Int $diff = abs($a.ord - $b.ord);
    min($diff, 26 - $diff);
}

sub minimum-time(Str $str where $str ~~ /^ <[a..z]>+ $/ --> Int) {
    my @characters = $str.comb;
    my Int $first-set = character-diff('a', @characters[0]);
    $first-set + @characters.elems + sum(
        map(
            {
                character-diff(@characters[$_],
                @characters[$_ + 1])
            },
            0..@characters.elems - 2
        )
    );
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is minimum-time("abc"), 5, 'works for "abc"';
    is minimum-time("bza"), 7, 'works for "bza"';
    is minimum-time("zjpc"), 34, 'works for "zjpc"';
}

#| Take user word like "abc"
multi sub MAIN(Str $str) {
    say minimum-time($str);
}
