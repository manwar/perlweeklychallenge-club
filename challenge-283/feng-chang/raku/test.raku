#!/bin/env raku

# The Weekly Challenge 283
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

# Task 1, Unique Number
pwc-test './ch-1.raku', <3 3 1>,       1, 'Unique Number: 3,3,1       => 1';
pwc-test './ch-1.raku', <3 2 4 2 4>,   3, 'Unique Number: 3,2,4,2,4   => 3';
pwc-test './ch-1.raku', 1,             1, 'Unique Number: 1           => 1';
pwc-test './ch-1.raku', <4 3 1 1 1 4>, 3, 'Unique Number: 4,3,1,1,1,4 => 3';

# Task 2, Digit Count Value
pwc-test './ch-2.raku', <1 2 1 0>, 'True',  'Digit Count Value: 1,2,1,0 => true';
pwc-test './ch-2.raku', <3 3 0>,   'False', 'Digit Count Value: 3,3,0   => false';
