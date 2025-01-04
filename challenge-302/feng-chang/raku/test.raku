#!/bin/env raku

# The Weekly Challenge 302
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

# Task 1, Ones and Zeroes
pwc-test './ch-1.raku', <10 0001 111001 1 0>, 5, 3, 4,
    'Ones and Zeroes: @str = <10 0001 111001 1 0>, $x=5, $y=3 => 4';
pwc-test './ch-1.raku', <10 1 0>, 1, 1, 2,
    'Ones and Zeroes: @str = <10 1 0>,             $x=1, $y=1 => 2';

# Task 2, Step by Step
pwc-test './ch-2.raku', '--', <-3 2 -3 4 2>, 5, 'Step by Step: -3,2,-3,4,2 => 5';
pwc-test './ch-2.raku', '--', <1 2>,         1, 'Step by Step: 1,2         => 1';
pwc-test './ch-2.raku', '--', <1 -2 -3>,     5, 'Step by Step: 1,-2,-3     => 5';
