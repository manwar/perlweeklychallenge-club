#!/bin/env raku

# The Weekly Challenge 217
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Sorted Matrix
pwc-test './ch-1.raku', '[3, 1, 2], [5, 2, 4], [0, 1, 3]', 1,
    "Sorted Matrix: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3]) => 1";
pwc-test './ch-1.raku', '[2, 1], [4, 5]', 4,
    "Sorted Matrix: @matrix = ([2, 1], [4, 5]) => 4";
pwc-test './ch-1.raku', '[1, 0, 3], [0, 0, 0], [1, 2, 1]', 0,
    "Sorted Matrix: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1]) => 0";

# Task 2, Max Number
pwc-test './ch-2.raku', |<1 23>,       231,    'Max Number: (1, 23)          =>    231';
pwc-test './ch-2.raku', |<10 3 2>,     3210,   'Max Number: (10, 3, 2)       =>   3210';
pwc-test './ch-2.raku', |<31 2 4 10>,  431210, 'Max Number: (31, 2, 4, 10)   => 431210';
pwc-test './ch-2.raku', |<5 11 4 1 2>, 542111, 'Max Number: (5, 11, 4, 1, 2) => 542111';
pwc-test './ch-2.raku', |<1 10>,       110,    'Max Number: (1, 10)          =>    110';

done-testing;
