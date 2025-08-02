#!/bin/env raku

# The Weekly Challenge 306
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

# Task 1, Odd Sum
pwc-test './ch-1.raku', <2 5 3 6 4>, 77, 'Odd Sum: 2,5,3,6,4 => 77';
pwc-test './ch-1.raku', <1 3>,        4, 'Odd Sum: 1,3       => 4';

# Task 2, Last Element
pwc-test './ch-2.raku', <3 8 5 2 9 2>, 1, 'Last Element: 3,8,5,2,9,2 => 1';
pwc-test './ch-2.raku', <3 2 5>,       0, 'Last Element: 3,2,5       => 0';
