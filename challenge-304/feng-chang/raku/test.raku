#!/bin/env raku

# The Weekly Challenge 304
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

# Task 1, Arrange Binary
pwc-test './ch-1.raku', <1 0 0 0 1>, 1, 'True',  'Arrange Binary: @digits = (1,0,0,0,1), $n=1 => true';
pwc-test './ch-1.raku', <1 0 0 0 1>, 2, 'False', 'Arrange Binary: @digits = (1,0,0,0,1), $n=2 => false';

# Task 2, Maximum Average
pwc-test './ch-2.raku', <1 12 -5 -6 50 3>, 4, 12.75, 'Maximum Average: @ints = (1,12,-5,-6,50,3), $n=4 => 12.75';
pwc-test './ch-2.raku', 5, 1, 5,                     'Maximum Average: @ints = (5),               $n=1 => 5';
