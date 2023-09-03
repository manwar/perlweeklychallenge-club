#!/bin/env raku

# The Weekly Challenge 228
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Unique Sum
pwc-test './ch-1.raku', |<2 1 3 2>, 4,  'Unique Sum: (2, 1, 3, 2) => 4';
pwc-test './ch-1.raku', |<1 1 1 1>, 0,  'Unique Sum: (1, 1, 1, 1) => 0';
pwc-test './ch-1.raku', |<2 1 3 4>, 10, 'Unique Sum: (2, 1, 3, 4) => 10';

# Task 2, Empty Array
pwc-test './ch-2.raku', |<3 4 2>, 5, 'Empty Array: (3, 4, 2) => 5';
pwc-test './ch-2.raku', |<1 2 3>, 3, 'Empty Array: (1, 2, 3) => 3';

done-testing;
