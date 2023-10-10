#!/bin/env raku

# The Weekly Challenge 238
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

# Task 1, Running Sum
pwc-test './ch-1.raku', |<1 2 3 4 5>, '1 3 6 10 15', 'Running Sum: (1, 2, 3, 4, 5)  => (1, 3, 6, 10, 15)';
pwc-test './ch-1.raku', |<1 1 1 1 1>, '1 2 3 4 5',   'Running Sum: (1, 1, 1, 1, 1)  => (1, 2, 3, 4, 5)';
pwc-test './ch-1.raku', |<0 -1 1 2>,  '0 -1 0 2',    'Running Sum: (0, -1, 1, 2)    => (0, -1, 0, 2)';

# Task 2, Persistence Sort
pwc-test './ch-2.raku', |<15 99 1 34>,  '1 15 34 99',  'Persistence Sort: (15, 99, 1, 34)  => (1, 15, 34, 99)';
pwc-test './ch-2.raku', |<50 25 33 22>, '22 33 50 25', 'Persistence Sort: (50, 25, 33, 22) => (22, 33, 50, 25)';

done-testing;
