#!/bin/env raku

# The Weekly Challenge 222
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Matching Members
pwc-test './ch-1.raku', |<1 1 4 2 1 3>, 3, 'Matching Members: 1, 1, 4, 2, 1, 3 => 3';
pwc-test './ch-1.raku',   |<5 1 2 3 4>, 0, 'Matching Members: 5, 1, 2, 3, 4 => 0';
pwc-test './ch-1.raku',   |<1 2 3 4 5>, 5, 'Matching Members: 1, 2, 3, 4, 5 => 5';

# Task 2, Last Member
pwc-test './ch-2.raku', |<2 7 4 1 8 1>, 1, 'Last Member: (2, 7, 4, 1, 8, 1) => 1';
pwc-test './ch-2.raku', |<1 1>, 0, 'Last Member: (1, 1) => 0';

done-testing;
