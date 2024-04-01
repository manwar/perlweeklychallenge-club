#!/bin/env raku

# The Weekly Challenge 236
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

# Task 1, Exact Change
pwc-test './ch-1.raku', |<5 5 5 10 20>,  'True',  'Exact Change: (5, 5, 5, 10, 20)  => True';
pwc-test './ch-1.raku', |<5 5 10 10 20>, 'False', 'Exact Change: (5, 5, 10, 10, 20) => False';
pwc-test './ch-1.raku', |<5 5 5 20>,     'True',  'Exact Change: (5, 5, 5, 20)      => True';

# Task 2, Array Loops
pwc-test './ch-2.raku',
    |<4 6 3 8 15 0 13 18 7 16 14 19 17 5 11 1 12 2 9 10>,
    3,
    'Array Loops: (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10) => 3';
pwc-test './ch-2.raku',
    |<0 1 13 7 6 8 10 11 2 14 16 4 12 9 17 5 3 18 15 19>,
    6,
    'Array Loops: (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19) => 6';
pwc-test './ch-2.raku',
    |<9 8 3 11 5 7 13 19 12 4 14 10 18 2 16 1 0 15 6 17>,
    1,
    'Array Loops: (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17) => 1';

done-testing;
