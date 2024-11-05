#!/bin/env raku

# The Weekly Challenge 294
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

# Task 1, Consecutive Sequence
pwc-test './ch-1.raku', <10 4 20 1 3 2>,       4, 'Consecutive Sequence: 10,4,20,1,3,2       => 4';
pwc-test './ch-1.raku', <0 6 1 8 5 2 4 3 0 7>, 9, 'Consecutive Sequence: 0,6,1,8,5,2,4,3,0,7 => 9';
pwc-test './ch-1.raku', <10 30 20>,           -1, 'Consecutive Sequence: 10,30,20            => -1';

# Task 2, Next Permutation
pwc-test './ch-2.raku', <2 4 1 7 5 0>, '2,4,5,0,1,7', 'Next Permutation: 2,4,1,7,5,0 => 2,4,5,0,1,7';
pwc-test './ch-2.raku', <1 2 3>,       '1,3,2',       'Next Permutation: 1,2,3       => 1,3,2';
pwc-test './ch-2.raku', <2 1 3>,       '2,3,1',       'Next Permutation: 2,1,3       => 2,3,1';
pwc-test './ch-2.raku', <3 1 2>,       '3,2,1',       'Next Permutation: 3,1,2       => 3,2,1';
