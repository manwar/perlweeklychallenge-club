#!/bin/env raku

# The Weekly Challenge 301
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

# Task 1, Largest Number
pwc-test './ch-1.raku', <20 3>,        320,     'Largest Number: 20,3        => 320';
pwc-test './ch-1.raku', <3 30 34 5 9>, 9534330, 'Largest Number: 3,30,34,5,9 => 9534330';

# Task 2, Hamming Distance
pwc-test './ch-2.raku', <4 14 2>, 6, 'Hamming Distance: 4,14,2 => 6';
pwc-test './ch-2.raku', <4 14 4>, 4, 'Hamming Distance: 4,14,4 => 4';
