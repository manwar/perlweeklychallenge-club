#!/bin/env raku

# The Weekly Challenge 268
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

# Task 1, Magic Number
pwc-test './ch-1.raku', '3,7,5', '9,5,7', 2, 'Magic Number: @x = (3, 7, 5) @y = (9, 5, 7) => 2';
pwc-test './ch-1.raku', '1,2,1', '5,4,4', 3, 'Magic Number: @x = (1, 2, 1) @y = (5, 4, 4) => 3';
pwc-test './ch-1.raku', <2 5>,            3, 'Magic Number: @x = (2)       @y = (5)       => 3';

# Task 2, Number Game
pwc-test './ch-2.raku', <2 5 3 4>,         '3 2 5 4',         'Number Game: (2, 5, 3, 4)             => (3, 2, 5, 4)';
pwc-test './ch-2.raku', <9 4 1 3 6 4 6 1>, '1 1 4 3 6 4 9 6', 'Number Game: (9, 4, 1, 3, 6, 4, 6, 1) => (1, 1, 4, 3, 6, 4, 9, 6)';
pwc-test './ch-2.raku', <1 2 2 3>,         '2 1 3 2',         'Number Game: (1, 2, 2, 3)             => (2, 1, 3, 2)';
