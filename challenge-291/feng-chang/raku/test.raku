#!/bin/env raku

# The Weekly Challenge 291
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

# Task 1, Middle Index
pwc-test './ch-1.raku', <2 3 -1 8 4>, 3, 'Middle Index: 2,3,-1,8,4  => 3';
pwc-test './ch-1.raku', <1 -1 4>,     2, 'Middle Index: 1,-1,4      => 2';
pwc-test './ch-1.raku', <2 5>,       -1, 'Middle Index: 2,5         => -1';
