#!/bin/env raku

# The Weekly Challenge 270
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

# Task 1, Special Positions
pwc-test './ch-1.raku', '[1,0,0],[0,0,1],[1,0,0]', 1, 'Special Positions: [[1,0,0],[0,0,1],[1,0,0]] => 1';
pwc-test './ch-1.raku', '[1,0,0],[0,1,0],[0,0,1]', 3, 'Special Positions: [[1,0,0],[0,1,0],[0,0,1]] => 3';

# Task 2, Distribute Elements
pwc-test './ch-2.raku', <4 1>,       3, 2, 9, 'Distribute Elements: @ints=(4,1),       $x=3, $y=2 => 9';
pwc-test './ch-2.raku', <2 3 3 3 5>, 2, 1, 6, 'Distribute Elements: @ints=(2,3,3,3,5), $x=2, $y=1 => 6';
pwc-test './ch-2.raku', <1 2 1>,     1, 3, 2, 'Distribute Elements: @ints=(1,2,1),     $x=1, $y=3 => 2';
