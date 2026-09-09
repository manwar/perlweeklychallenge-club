#!/bin/env raku

# The Weekly Challenge 380
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

# Task 1, Sum of Frequencies
pwc-test './ch-1.raku', 'banana',   5, 'Sum of Frequencies: banana   => 5';
pwc-test './ch-1.raku', 'teestett', 7, 'Sum of Frequencies: teestett => 7';
pwc-test './ch-1.raku', 'aeiouuaa', 3, 'Sum of Frequencies: aeiouuaa => 3';
pwc-test './ch-1.raku', 'rhythm',   2, 'Sum of Frequencies: rhythm   => 2';
pwc-test './ch-1.raku', 'x',        1, 'Sum of Frequencies: x        => 1';

# Task 2, Reverse Degree
pwc-test './ch-2.raku', 'z',       1,   'Reverse Degree: z       => 1';
pwc-test './ch-2.raku', 'a',       26,  'Reverse Degree: a       => 26';
pwc-test './ch-2.raku', 'bbc',     147, 'Reverse Degree: bbc     => 147';
pwc-test './ch-2.raku', 'racecar', 560, 'Reverse Degree: racecar => 560';
pwc-test './ch-2.raku', 'zyx',     14,  'Reverse Degree: zyx     => 14';
