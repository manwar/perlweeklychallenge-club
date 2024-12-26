#!/bin/env raku

# The Weekly Challenge 300
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

# Task 1, Beautiful Arrangements
pwc-test './ch-1.raku', 1, 1, 'Beautiful Arrangements: 1 => 1';
pwc-test './ch-1.raku', 2, 2, 'Beautiful Arrangements: 2 => 2';
pwc-test './ch-1.raku', 3, 3, 'Beautiful Arrangements: 3 => 3';
pwc-test './ch-1.raku', 4, 8, 'Beautiful Arrangements: 4 => 8';
pwc-test './ch-1.raku', 5, 10, 'Beautiful Arrangements: 5 => 10';
pwc-test './ch-1.raku', 6, 36, 'Beautiful Arrangements: 6 => 36';
pwc-test './ch-1.raku', 7, 41, 'Beautiful Arrangements: 7 => 41';
pwc-test './ch-1.raku', 8, 132, 'Beautiful Arrangements: 8 => 132';
pwc-test './ch-1.raku', 9, 250, 'Beautiful Arrangements: 9 => 250';
pwc-test './ch-1.raku', 10, 700, 'Beautiful Arrangements: 10 => 700';

# Task 2, Nested Array
pwc-test './ch-2.raku', <5 4 0 3 1 6 2>, 4, 'Nested Array: 5,4,0,3,1,6,2 => 4';
pwc-test './ch-2.raku', <0 1 2>,         1, 'Nested Array: 0,1,2         => 1';
