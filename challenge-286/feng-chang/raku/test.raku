#!/bin/env raku

# The Weekly Challenge 286
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

# Task 2, Order Game
pwc-test './ch-2.raku', <2 1 4 5 6 3 0 2>, 1, 'Order Game: 2,1,4,5,6,3,0,2 => 1';
pwc-test './ch-2.raku', <0 5 3 2>,         0, 'Order Game: 0,5,3,2         => 0';
pwc-test './ch-2.raku', <9 2 1 4 5 6 0 7 3 1 3 5 7 9 0 8>, 2, 'Order Game: 9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8 => 2';
