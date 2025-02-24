#!/bin/env raku

# The Weekly Challenge 309
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

# Task 1, Min Gap
pwc-test './ch-1.raku', <2 8 10 11 15>, 11, 'Min Gap: 2,8,10,11,15 => 11';
pwc-test './ch-1.raku', <1 5 6 7 14>,    6, 'Min Gap: 1,5,6,7,14   =>  6';
pwc-test './ch-1.raku', <8 20 25 28>,   28, 'Min Gap: 8,20,25,28   => 28';
pwc-test './ch-1a.raku', <2 8 10 11 15>, 11, 'Min Gap: 2,8,10,11,15 => 11';
pwc-test './ch-1a.raku', <1 5 6 7 14>,    6, 'Min Gap: 1,5,6,7,14   =>  6';
pwc-test './ch-1a.raku', <8 20 25 28>,   28, 'Min Gap: 8,20,25,28   => 28';

# Task 2, Nested Array
pwc-test './ch-2.raku', <1 5 8 9>, 1, 'Min Gap: 1,5,8,9 => 1';
pwc-test './ch-2.raku', <9 4 1 7>, 2, 'Min Gap: 9,4,1,7 => 2';
