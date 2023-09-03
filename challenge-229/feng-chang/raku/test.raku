#!/bin/env raku

# The Weekly Challenge 229
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Lexicographic Order
pwc-test './ch-1.raku', |<abc bce cae>, 1, 'Lexicographic Order: ("abc", "bce", "cae") => 1';
pwc-test './ch-1.raku', |<yxz cba mon>, 2, 'Lexicographic Order: ("yxz", "cba", "mon") => 2';

# Task 2, Two out of Three
pwc-test './ch-2.raku', 'data01.txt', '2 4',   'Two out of Three: data01.txt => 2, 4';
pwc-test './ch-2.raku', 'data02.txt', '1 2 4', 'Two out of Three: data02.txt => 1, 2, 4';

done-testing;
