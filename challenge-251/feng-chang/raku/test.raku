#!/bin/env raku

# The Weekly Challenge 251
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

# Task 1, Concatenation Value
pwc-test './ch-1.raku', |<6 12 25 1>,     1286, 'Concatenation Value: (6, 12, 25, 1)       => 1286';
pwc-test './ch-1.raku', |<10 7 31 5 2 2>, 489,  'Concatenation Value: (10, 7, 31, 5, 2, 2) => 489';
pwc-test './ch-1.raku', |<1 2 10>,        112,  'Concatenation Value: (1, 2, 10)           => 112';

# Task 2, Lucky Numbers
pwc-test './ch-2.raku',
    '[3, 7, 8], [9, 11, 13], [15, 16, 17]',
    15,
    'Lucky Numbers: [[3, 7, 8], [9, 11, 13], [15, 16, 17]]          => 15';
pwc-test './ch-2.raku',
    '[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]',
    12,
    'Lucky Numbers: [[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]] => 12';
pwc-test './ch-2.raku',
    '[7, 8], [1, 2]',
    7,
    'Lucky Numbers: [[7, 8], [1, 2]]                                => 7';
pwc-test './ch-2.raku',
    '[1, 3], [4, 2]',
    -1,
    'Lucky Numbers: [[1, 3], [4, 2]]                                => -1';

done-testing;
