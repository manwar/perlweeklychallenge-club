#!/bin/env raku

# The Weekly Challenge 247
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

# Task 2, Most Frequent Letter Pair
pwc-test './ch-2.raku', 'abcdbca',           'bc', 'Most Frequent Letter Pair: abcdbca           => bc';
pwc-test './ch-2.raku', 'cdeabeabfcdfabgcd', 'ab', 'Most Frequent Letter Pair: cdeabeabfcdfabgcd => ab';

done-testing;
