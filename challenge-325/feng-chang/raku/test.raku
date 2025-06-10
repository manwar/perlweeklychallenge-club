#!/bin/env raku

# The Weekly Challenge 325
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

# Task 1, Consecutive One
pwc-test './ch-1.raku', '0110111', 3, 'Consecutive One: 0110111 => 3';
pwc-test './ch-1.raku', '0000',    0, 'Consecutive One: 0000    => 0';
pwc-test './ch-1.raku', '101011',  2, 'Consecutive One: 101011  => 2';

# Task 2, Final Price
pwc-test './ch-2.raku', <8 4 6 2 3>, '4 2 4 2 3', 'Final Price: 8,4,6,2,3 => 4,2,4,2,3';
pwc-test './ch-2.raku', <1 2 3 4 5>, '1 2 3 4 5', 'Final Price: 1,2,3,4,5 => 1,2,3,4,5';
pwc-test './ch-2.raku', <7 1 1 5>,   '6 0 1 5',   'Final Price: 7,1,1,5   => 6,0,1,5';
