#!/bin/env raku

# The Weekly Challenge 243
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

# Task 1, Reverse Pairs
pwc-test './ch-1.raku', |<1 3 2 3 1>, 2, 'Reverse Pairs: @nums = (1, 3, 2, 3, 1) => 2';
pwc-test './ch-1.raku', |<2 4 3 5 1>, 3, 'Reverse Pairs: @nums = (2, 4, 3, 5, 1) => 3';

# Task 2, Floor Sum
pwc-test './ch-2.raku', |<2 5 9>,         10, 'Floor Sum: (2, 5, 9)             => 10';
pwc-test './ch-2.raku', |<7 7 7 7 7 7 7>, 49, 'Floor Sum: (7, 7, 7, 7, 7, 7, 7) => 49';

done-testing;
