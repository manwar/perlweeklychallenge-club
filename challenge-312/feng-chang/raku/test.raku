#!/bin/env raku

# The Weekly Challenge 312
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

# Task 1, Minimum Time
pwc-test './ch-1.raku', 'abc',  6,  'Minimum Time: abc  => 6';
pwc-test './ch-1.raku', 'bza',  7,  'Minimum Time: bza  => 7';
pwc-test './ch-1.raku', 'zjpc', 34, 'Minimum Time: zjpc => 34';

# Task 2, Balls and Boxes
pwc-test './ch-2.raku', 'G0B1R2R0B0',         1, 'Balls and Boxes: G0B1R2R0B0         => 1';
pwc-test './ch-2.raku', 'G1R3R6B3G6B1B6R1G3', 3, 'Balls and Boxes: G1R3R6B3G6B1B6R1G3 => 3';
pwc-test './ch-2.raku', 'B3B2G1B3',           0, 'Balls and Boxes: B3B2G1B3           => 0';
