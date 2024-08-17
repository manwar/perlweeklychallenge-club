#!/bin/env raku

# The Weekly Challenge 281
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Check Color
pwc-test './ch-1.raku', 'd3', 'True',  'Check Color: d3 => true';
pwc-test './ch-1.raku', 'g5', 'False', 'Check Color: g5 => false';
pwc-test './ch-1.raku', 'e6', 'True',  'Check Color: e6 => true';

# Task 2, Knight's Move
pwc-test './ch-2.raku', <g2 a8>, 4, "Knight\'s Move: g2, a8 => 4";
pwc-test './ch-2.raku', <g2 h2>, 3, "Knight\'s Move: g2, h2 => 3";
pwc-test './ch-2.raku', <a1 b4>, 2, "Knight\'s Move: a1, b4 => 2";
pwc-test './ch-2.raku', <a1 a4>, 3, "Knight\'s Move: a1, a4 => 3";
pwc-test './ch-2.raku', <a1 a5>, 2, "Knight\'s Move: a1, a5 => 2";
pwc-test './ch-2.raku', <a1 a6>, 3, "Knight\'s Move: a1, a6 => 3";
