#!/bin/env raku

# The Weekly Challenge 297
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

# Task 1, Contiguous Array
pwc-test './ch-1.raku', <1 0>,         2, 'Contiguous Array: 1,0         => 2';
pwc-test './ch-1.raku', <0 1>,         2, 'Contiguous Array: 0,1         => 2';
pwc-test './ch-1.raku', <0 1 0>,       2, 'Contiguous Array: 0,1,0       => 2';
pwc-test './ch-1.raku', <0 0 0 0 0>,   0, 'Contiguous Array: 0,0,0,0,0   => 0';
pwc-test './ch-1.raku', <0 1 0 0 1 0>, 4, 'Contiguous Array: 0,1,0,0,1,0 => 4';

# Task 2, Semi-Ordered Permutation
pwc-test './ch-2.raku', <2 1 4 3>,   2, 'Semi-Ordered Permutation: 2,1,4,3   => 2';
pwc-test './ch-2.raku', <2 1 3 4>,   1, 'Semi-Ordered Permutation: 2,1,3,4   => 1';
pwc-test './ch-2.raku', <2 4 1 3>,   3, 'Semi-Ordered Permutation: 2,4,1,3   => 3';
pwc-test './ch-2.raku', <1 3 2 4 5>, 0, 'Semi-Ordered Permutation: 1,3,2,4,5 => 0';
