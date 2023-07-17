#!/bin/env raku

# The Weekly Challenge 226
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Shuffle String
pwc-test './ch-1.raku', 'lacelengh', |<3 2 0 5 4 8 6 7 1>,
    'challenge',
    "Shuffle String: \$string = 'lacelengh', \@indices = (3,2,0,5,4,8,6,7,1) => 'challenge'";
pwc-test './ch-1.raku', 'rulepark', |<4 7 3 1 0 5 2 6>,
    'perlraku',
    "Shuffle String: \$string = 'rulepark',  \@indices = (4,7,3,1,0,5,2,6)   => 'perlraku'";

# Task 2, Zero Arry
pwc-test './ch-2.raku', |<1 5 0 3 5>, 3, 'Zero Array: (1, 5, 0, 3, 5) => 3';
pwc-test './ch-2.raku', 0,            0, 'Zero Array: (0)             => 0';
pwc-test './ch-2.raku', |<2 1 4 0 3>, 4, 'Zero Array: (2, 1, 4, 0, 3) => 4';

done-testing;
