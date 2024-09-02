#!/bin/env raku

# The Weekly Challenge 285
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

# Task 1, No Connection
pwc-test './ch-1.raku', 'BCDBCA', 'A', 'No Connection: B=>C,D=>B,C=>A  => A';
pwc-test './ch-1.raku', 'AZ',     'Z', 'No Connection: A=>Z            => Z';

# Task 2, Maing Change
pwc-test './ch-2.raku',  9,    2, 'Maing Change:   9 =>   2';
pwc-test './ch-2.raku',  15,   6, 'Maing Change:  15 =>   6';
pwc-test './ch-2.raku', 100, 292, 'Maing Change: 100 => 292';
