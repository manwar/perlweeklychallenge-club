#!/bin/env raku

# The Weekly Challenge 339
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

# Task 1, Max Diff
pwc-test './ch-1.raku', <5 9 3 4 6>,      42, 'Max Diff: (5,9,3,4,6)   => 42';
pwc-test './ch-1.raku', <1 -2 3 -4>,      10, 'Max Diff: (1,-2,3,-4)   => 10';
pwc-test './ch-1.raku', <-- -3 -1 -2 -4>, 10, 'Max Diff: (-3,-1,-2,-4) => 10';
pwc-test './ch-1.raku', <10 2 0 5 1>,     50, 'Max Diff: (10,2,0,5,1)  => 50';
pwc-test './ch-1.raku', <7 8 9 10 10>,    44, 'Max Diff: (7,8,9,10,10) => 44';

# Task 2, Peak Point
pwc-test './ch-2.raku', <-- -5 1 5 -9 2>,  1, 'Peak Point: (-5,1,5,-9,2)   =>  1';
pwc-test './ch-2.raku', <10 10 10 -25>,   30, 'Peak Point: (10,10,10,-25)  => 30';
pwc-test './ch-2.raku', <3 -4 2 5 -6 1>,   6, 'Peak Point: (3,-4,2,5,-6,1) =>  6';
pwc-test './ch-2.raku', <-- -1 -2 -3 -4>,  0, 'Peak Point: (-1,-2,-3,-4)   =>  0';
pwc-test './ch-2.raku', <-- -10 15 5>,    10, 'Peak Point: (-10,15,5)      => 10';
