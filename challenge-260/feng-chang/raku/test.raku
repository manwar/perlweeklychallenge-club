#!/bin/env raku

# The Weekly Challenge 260
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

# Task 1, Unique Occurrences
pwc-test './ch-1.raku', <1 2 2 1 1 3>,               1, 'Unique Occurrences: (1,2,2,1,1,3)            => 1';
pwc-test './ch-1.raku', <1 2 3>,                     0, 'Unique Occurrences: (1,2,3)                  => 0';
pwc-test './ch-1.raku', <-- -2 0 1 -2 1 1 0 1 -2 9>, 1, 'Unique Occurrences: (-2,0,1,-2,1,1,0,1,-2,9) => 1';

# Task 2, Dictionary Rank
pwc-test './ch-2.raku', 'CAT',    3,   'Dictionary Rank: CAT    => 3';
pwc-test './ch-2.raku', 'GOOGLE', 88,  'Dictionary Rank: GOOGLE => 88';
pwc-test './ch-2.raku', 'SECRET', 255, 'Dictionary Rank: SECRET => 255';
