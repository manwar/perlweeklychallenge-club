#!/bin/env raku

# The Weekly Challenge 290
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

# Task 1, Double Exist
pwc-test './ch-1.raku',  <6 2 3 3>,  'True',  'Double Exist: 6,2,3,3  => true';
pwc-test './ch-1.raku',  <3 1 4 13>, 'False', 'Double Exist: 3,1,4,13 => false';
pwc-test './ch-1.raku',  <2 1 4 2>,  'True',  'Double Exist: 2,1,4,2  => true';
pwc-test './ch-1a.raku',  <6 2 3 3>,  'True',  'Double Exist: 6,2,3,3  => true';
pwc-test './ch-1a.raku',  <3 1 4 13>, 'False', 'Double Exist: 3,1,4,13 => false';
pwc-test './ch-1a.raku',  <2 1 4 2>,  'True',  'Double Exist: 2,1,4,2  => true';

# Task 2, Luhn’s Algorithm
pwc-test './ch-2.raku', '17893729974',         'True',  'Luhn’s Algorithm: "17893729974"         => true';
pwc-test './ch-2.raku', '4137 8947 1175 5904', 'True',  'Luhn’s Algorithm: "4137 8947 1175 5904" => true';
pwc-test './ch-2.raku', '4137 8974 1175 5904', 'False', 'Luhn’s Algorithm: "4137 8947 1175 5904" => false';
