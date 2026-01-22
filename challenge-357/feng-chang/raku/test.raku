#!/bin/env raku

# The Weekly Challenge 357
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

# Task 1, Kaprekar Constant
pwc-test './ch-1.raku', 3524,  3, 'Kaprekar Constant: 3524 => 3';
pwc-test './ch-1.raku', 6174,  0, 'Kaprekar Constant: 6174 => 0';
pwc-test './ch-1.raku', 9998,  5, 'Kaprekar Constant: 9998 => 5';
pwc-test './ch-1.raku', 1001,  4, 'Kaprekar Constant: 1001 => 4';
pwc-test './ch-1.raku', 9000,  4, 'Kaprekar Constant: 9000 => 4';
pwc-test './ch-1.raku', 1111, -1, 'Kaprekar Constant: 1111 => -1';

# Task 2, Unique Fraction Generator
pwc-test './ch-2.raku', 3,
    '1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1',
    'Unique Fraction Generator: 3';
pwc-test './ch-2.raku', 4,
    '1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1',
    'Unique Fraction Generator: 4';
pwc-test './ch-2.raku', 1,
    '1/1',
    'Unique Fraction Generator: 1';
pwc-test './ch-2.raku', 6,
    '1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1',
    'Unique Fraction Generator: 6';
pwc-test './ch-2.raku', 5,
    '1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1',
    'Unique Fraction Generator: 5';
