#!/bin/env raku

# The Weekly Challenge 327
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

# Task 1, Missing Integers
pwc-test './ch-1.raku', <1 2 1 3 2 5>, '4 6', 'Missing Integers: (1,2,1,3,2,5) => (4,6)';
pwc-test './ch-1.raku', <1 1 1>,       '2 3', 'Missing Integers: (1,1,1)       => (2,3)';
pwc-test './ch-1.raku', <2 2 1>,       '3',   'Missing Integers: (2,2,1)       => (3)';

# Task 2, MAD
pwc-test './ch-2.raku', <4 1 2 3>,     '[1,2], [2,3], [3,4]', 'MAD: (4,1,2,3)     => [1,2],[2,3],[3,4]';
pwc-test './ch-2.raku', <1 3 7 11 15>, '[1,3]',               'MAD: (1,3,7,11,15) => [1,3]';
pwc-test './ch-2.raku', <1 5 3 8>,     '[1,3], [3,5]',        'MAD: (1,5,3,8)     => [1,3],[3,5]';
