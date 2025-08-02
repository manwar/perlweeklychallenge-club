#!/bin/env raku

# The Weekly Challenge 235
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

# Task 1, Remove One
pwc-test './ch-1.raku', |<0 2 9 4 6>, 'True',  'Remove One: (0, 2, 9, 4, 6) => True';
pwc-test './ch-1.raku', |<5 1 3 2>,   'False', 'Remove One: (5, 1, 3, 2)    => False';
pwc-test './ch-1.raku', |<2 2 3>,     'True',  'Remove One: (2, 2, 3)       => True';

# Task 2, Duplicate Zeros
pwc-test './ch-2.raku', |<1 0 2 3 0 4 5 0>, '1 0 0 2 3 0 0 4',  'Duplicate Zeros: (1, 0, 2, 3, 0, 4, 5, 0) => (1, 0, 0, 2, 3, 0, 0, 4)';
pwc-test './ch-2.raku', |<1 2 3>,           '1 2 3',            'Duplicate Zeros: (1, 2, 3)                => (1, 2, 3)';
pwc-test './ch-2.raku', |<0 3 0 4 5>,       '0 0 3 0 0',        'Duplicate Zeros: (0, 3, 0, 4, 5)          => (0, 0, 3, 0, 0)';

done-testing;
