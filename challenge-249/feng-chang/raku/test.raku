#!/bin/env raku

# The Weekly Challenge 249
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

# Task 1, Equal Pairs
pwc-test './ch-1.raku', |<3 2 3 2 2 2>, '(2, 2), (2, 2), (3, 3)', 'Equal Pairs: (3, 2, 3, 2, 2, 2) => (2, 2), (2, 2), (3, 3)';
pwc-test './ch-1.raku', |<1 2 3 4>,     '()',                     'Equal Pairs: (1, 2, 3, 4)       => ()';

# Task 2, DI String Match
pwc-test './ch-2.raku', 'IDID', '(0, 4, 1, 3, 2)', 'DI String Match: IDID => (0, 4, 1, 3, 2)';
pwc-test './ch-2.raku', 'III',  '(0, 1, 2, 3)',    'DI String Match: III  => (0, 1, 2, 3)';
pwc-test './ch-2.raku', 'DDI',  '(3, 2, 0, 1)',    'DI String Match: DDI  => (3, 2, 0, 1)';

done-testing;
