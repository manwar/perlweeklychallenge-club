#!/bin/env raku

# The Weekly Challenge 320
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

# Task 1, Maximum Count
pwc-test './ch-1.raku', '--', <-3 -2 -1 1 2 3>, 3, 'Maximum Count: (-3,-2,-1,1,2,3) => 3';
pwc-test './ch-1.raku', '--', <-2 -1 0 0 1>,    2, 'Maximum Count: (-2,-1,0,0,1)    => 2';
pwc-test './ch-1.raku', '--', <1 2 3 4>,        4, 'Maximum Count: (1,2,3,4)        => 4';

# Task 2, Sum Difference
pwc-test './ch-2.raku', <1 23 4 5>,  18, 'Sum Difference: (1,23,4,5)  => 18';
pwc-test './ch-2.raku', <1 2 3 4 5>,  0, 'Sum Difference: (1,2,3,4,5) =>  0';
pwc-test './ch-2.raku', <1 2 34>,    27, 'Sum Difference: (1,2,34)    => 27';
