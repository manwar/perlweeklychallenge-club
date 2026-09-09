#!/bin/env raku

# The Weekly Challenge 381
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

# Task 1, Same Row Column
pwc-test './ch-1.raku', '[1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3]', 'True',  'Same Row Column: [1,2,3,4],[2,3,4,1],[3,4,1,2],[4,1,2,3] => true';
pwc-test './ch-1.raku', '[1]',                                     'True',  'Same Row Column: [1]                                     => true';
pwc-test './ch-1.raku', '[1,2,5],[5,1,2],[2,5,1]',                 'False', 'Same Row Column: [1,2,5],[5,1,2],[2,5,1]                 => false';
pwc-test './ch-1.raku', '[1,2,3],[1,2,3],[1,2,3]',                 'False', 'Same Row Column: [1,2,3],[1,2,3],[1,2,3]                 => false';
pwc-test './ch-1.raku', '[1,2,3],[3,1,2],[3,2,1]',                 'False', 'Same Row Column: [1,2,3],[3,1,2],[3,2,1]                 => false';

# Task 2, Smaller Greater Element
pwc-test './ch-2.raku', <2 4>,           0, 'Smaller Greater Element: (2, 4)               => 0';
pwc-test './ch-2.raku', <1 1 1 1>,       0, 'Smaller Greater Element: (1, 1, 1, 1)         => 0';
pwc-test './ch-2.raku', <1 1 4 8 12 12>, 2, 'Smaller Greater Element: (1, 1, 4, 8, 12, 12) => 2';
pwc-test './ch-2.raku', <3 6 6 9>,       2, 'Smaller Greater Element: (3, 6, 6, 9)         => 2';
pwc-test './ch-2.raku', <0 -5 10 -2 4>,  3, 'Smaller Greater Element: (0, -5, 10, -2, 4)   => 3';
