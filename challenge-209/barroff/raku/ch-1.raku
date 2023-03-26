#!/usr/bin/env raku

use v6.d;

grammar Sbc {
    regex TOP { <prelude> <end> }
    token a { '0' }
    token b { '10' }
    token c { '11' }
    regex prelude { ^ [ <a> | <b> | <c> ]* }
    token end { <a> $ }
}

sub special-bit-characters(Int @numbers --> Int) {
    my Str $bit-string = @numbers.join;
    Sbc.parse($bit-string) ?? 1 !! 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is special-bit-characters(Array[Int].new([1, 0, 0])), 1, "works for (1, 0, 0)";
    is special-bit-characters(Array[Int].new([1, 1, 1, 0])), 0, "works for (1, 1, 1, 0)";
}

#| Take user provided list like 1 1 1 0
multi sub MAIN(*@elements where @elements.elems ≥ 1 && all(@elements) ~~ /^<[01]>$/) {
    my Int @int-elements = @elements;
    say "the result is { special-bit-characters(@int-elements) }"
}

