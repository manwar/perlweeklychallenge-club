#!/bin/env raku

# The Weekly Challenge 262
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

# Task 1, Max Positive Negative
pwc-test './ch-1.raku', <-- -3 1 2 -1 3 -2 4>, 4, 'Max Positive Negative: (-3,1,2,-1,3,-2,4) => 4';
pwc-test './ch-1.raku', <-- -1 -2 -3 1>,       3, 'Max Positive Negative: (-1,-2,-3,1)       => 3';
pwc-test './ch-1.raku', <-- 1 2>,              2, 'Max Positive Negative: (1,2)              => 2';

pwc-test './ch-1a.raku', <-- -3 1 2 -1 3 -2 4>, 4, 'Max Positive Negative: (-3,1,2,-1,3,-2,4) => 4';
pwc-test './ch-1a.raku', <-- -1 -2 -3 1>,       3, 'Max Positive Negative: (-1,-2,-3,1)       => 3';
pwc-test './ch-1a.raku', <-- 1 2>,              2, 'Max Positive Negative: (1,2)              => 2';

pwc-test './ch-1b.raku', <-- -3 1 2 -1 3 -2 4>, 4, 'Max Positive Negative: (-3,1,2,-1,3,-2,4) => 4';
pwc-test './ch-1b.raku', <-- -1 -2 -3 1>,       3, 'Max Positive Negative: (-1,-2,-3,1)       => 3';
pwc-test './ch-1b.raku', <-- 1 2>,              2, 'Max Positive Negative: (1,2)              => 2';

# Task 2, Count Equal Divisible
pwc-test './ch-2.raku', <3 1 2 2 2 1 3>, 2, 4, 'Count Equal Divisible: @ints=(3,1,2,2,2,1,3), $k=2 => 4';
pwc-test './ch-2.raku', <1 2 3>,         1, 0, 'Count Equal Divisible: @ints=(1,2,3), $k=1         => 0';
