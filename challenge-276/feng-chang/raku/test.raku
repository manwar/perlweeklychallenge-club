#!/bin/env raku

# The Weekly Challenge 276
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

# Task 1, Complete Day
pwc-test './ch-1.raku', <12 12 30 24 24>, 2, 'Complete Day: 12, 12, 30, 24, 24 => 2';
pwc-test './ch-1.raku', <72 48 24 5>,     3, 'Complete Day: 72, 48, 24, 5      => 3';
pwc-test './ch-1.raku', <12 18 24>,       0, 'Complete Day: 12, 18, 24         => 0';

# Task 2, Maximum Frequency
pwc-test './ch-2.raku', <1 2 2 4 1 5>, 4, 'Maximum Frequency: 1, 2, 2, 4, 1, 5 => 4';
pwc-test './ch-2.raku', <1 2 3 4 5>,   5, 'Maximum Frequency: 1, 2, 3, 4, 5    => 5';
pwc-test './ch-2a.raku', <1 2 2 4 1 5>, 4, 'Maximum Frequency: 1, 2, 2, 4, 1, 5 => 4';
pwc-test './ch-2a.raku', <1 2 3 4 5>,   5, 'Maximum Frequency: 1, 2, 3, 4, 5    => 5';
