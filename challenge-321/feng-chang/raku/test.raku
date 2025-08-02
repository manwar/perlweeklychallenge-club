#!/bin/env raku

# The Weekly Challenge 321
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

# Task 1, Distinct Average
pwc-test './ch-1.raku', <1 2 4 3 5 6>, 1, 'Distinct Average: (1,2,4,3,5,6) => 1';
pwc-test './ch-1.raku', <0 2 4 8 3 5>, 2, 'Distinct Average: (0,2,4,8,3,5) => 2';
pwc-test './ch-1.raku', <7 3 1 0 5 9>, 2, 'Distinct Average: (7,3,1,0,5,9) => 2';

# Task 2, Backspace Compare
pwc-test './ch-2.raku', <ab#c ad#c>, 'True',  'Backspace Compare: <ab*c ad*c> => true';
pwc-test './ch-2.raku', <ab## a#b#>, 'True',  'Backspace Compare: <ab** a*b*> => true';
pwc-test './ch-2.raku', <a#b c>,     'False', 'Backspace Compare: <a*b c>     => false';
