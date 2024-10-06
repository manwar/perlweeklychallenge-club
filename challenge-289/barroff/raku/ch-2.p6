#!/usr/bin/env raku

use v6.d;

sub jumble(Str $word --> Str) {
    return $word if $word.chars < 3;
    my @split-word = $word.comb;
    return @split-word[0]
        ~ @split-word[1..*-2].pick(@split-word.elems - 2).join
        ~ @split-word[*-1]
}

sub jumbled-letters(Str $str --> Str) {
    map({ jumble($_) }, words($str) ).join(" ");
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 7;

    srand(42);
    is jumbled-letters("Nim"), "Nim", 'works for "Nim"';
    is jumbled-letters("BQN"), "BQN", 'works for "BQN"';
    is jumbled-letters("Raku"), "Rkau", 'works for "Raku"';
    is jumbled-letters("Perl"), "Perl", 'works for "Perl"';
    is jumbled-letters("Julia"), "Jiula", 'works for "Julia"';
    is jumbled-letters("Go"), "Go", 'works for "Go"';
    is jumbled-letters("J"), "J", 'works for "J"';
}

#| Take user provided word like "Perl"
multi sub MAIN(Str $word) {
    say jumbled-letters($word);
}

