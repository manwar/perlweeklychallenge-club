#!/bin/env raku

# The Weekly Challenge 261
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

# Task 1, Element Digit Sum
pwc-test './ch-1.raku', <1 2 3 45>,          36, 'Element Digit Sum: (1,2,3,45)           => 36';
pwc-test './ch-1.raku', <1 12 3>,             9, 'Element Digit Sum: (1,12,3)             => 9';
pwc-test './ch-1.raku', <1 2 3 4>,            0, 'Element Digit Sum: (1,2,3,4)            => 0';
pwc-test './ch-1.raku', <236 416 336 350>, 1296, 'Element Digit Sum: (236, 416, 336, 350) => 1296';

# Task 2, Multiply by Two
pwc-test './ch-2.raku', <5 3 6 1 12>, 3, 24, 'Multiply by Two: @ints=(5,3,6,1,12), $start=3 => 24';
pwc-test './ch-2.raku', <1 2 4 3>,    1,  8, 'Multiply by Two: @ints=(1,2,4,3),    $start=1 => 8';
pwc-test './ch-2.raku', <5 6 7>,      2,  2, 'Multiply by Two: @ints=(5,6,7),      $start=2 => 2';

pwc-test './ch-2a.raku', <5 3 6 1 12>, 3, 24, 'Multiply by Two: @ints=(5,3,6,1,12), $start=3 => 24';
pwc-test './ch-2a.raku', <1 2 4 3>,    1,  8, 'Multiply by Two: @ints=(1,2,4,3),    $start=1 => 8';
pwc-test './ch-2a.raku', <5 6 7>,      2,  2, 'Multiply by Two: @ints=(5,6,7),      $start=2 => 2';
