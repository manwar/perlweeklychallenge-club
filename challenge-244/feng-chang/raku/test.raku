#!/bin/env raku

# The Weekly Challenge 244
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

# Task 1, Count Smaller
pwc-test './ch-1.raku', |<8 1 2 2 3>, '4 0 1 1 3', 'Count Smaller: @nums = (8, 1, 2, 2, 3) => (4, 0, 1, 1, 3)';
pwc-test './ch-1.raku', |<6 5 4 8>,   '2 1 0 3',   'Count Smaller: @nums = (6, 5, 4, 8)    => (2, 1, 0, 3)';
pwc-test './ch-1.raku', |<2 2 2>,     '0 0 0',     'Count Smaller: @nums = (2, 2, 2)       => (0, 0, 0)';

# Task 2, Group Hero
pwc-test './ch-2.raku', |<2 1 4>, 141, 'Group Hero: (2, 1, 4) => 141';

done-testing;
