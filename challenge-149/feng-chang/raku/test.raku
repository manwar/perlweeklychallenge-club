#!/bin/env raku

# The Weekly Challenge 149
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

# Task 1, Fibonacci Digit Sum
pwc-test './ch-1.raku', 20, '0 1 2 3 5 8 10 11 12 14 17 20 21 23 26 30 32 35 41 44',
    'Fibonacci Digit Sum: 20 => 0,1,2,3,5,8,10,11,12,14,17,20,21,23,26,30,32,35,41,44';

# Task 2, Largest Square
pwc-test './ch-2.raku', 2,  1,              'Largest Square: 2  => 1';
pwc-test './ch-2.raku', 4,  3201,           'Largest Square: 4  => 3201';
pwc-test './ch-2.raku', 10, 9814072356,     'Largest Square: 10 => 9814072356';
pwc-test './ch-2.raku', 12, 'B8750A649321', 'Largest Square: 12 => B8750A649321';
