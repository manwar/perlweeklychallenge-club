#!/bin/env raku

# The Weekly Challenge 289
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

# Task 1, Third Maximum
pwc-test './ch-1.raku',  <5 6 4 1>, 4, 'Third Maximum: 5, 6, 4, 1 => 4';
pwc-test './ch-1.raku',  <4 5>,     5, 'Third Maximum: 4, 5       => 5';
pwc-test './ch-1.raku',  <1 2 2 3>, 1, 'Third Maximum: 1, 2, 2, 3 => 1';
pwc-test './ch-1.raku',  <1 2 1 2>, 2, 'Third Maximum: 1, 2, 1, 2 => 2';
