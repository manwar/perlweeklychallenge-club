#!/bin/env raku

# The Weekly Challenge 246
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

# Task 2, Linear Recurrence of Second Order
pwc-test './ch-2.raku', |<1 1 2 3 5>,  'True',  'Linear Recurrence of Second Order: (1, 1, 2, 3, 5)  => True';
pwc-test './ch-2.raku', |<4 2 4 5 7>,  'False', 'Linear Recurrence of Second Order: (1, 1, 2, 3, 5)  => False';
pwc-test './ch-2.raku', |<4 1 2 -3 8>, 'True',  'Linear Recurrence of Second Order: (4, 1, 2, -3, 8) => True';

done-testing;
