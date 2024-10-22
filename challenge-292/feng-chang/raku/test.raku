#!/bin/env raku

# The Weekly Challenge 292
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

# Task 1, Twice Largest
pwc-test './ch-1.raku', <2 4 1 0>,  4, 'Twice Largest: 2,4,1,0  =>  4';
pwc-test './ch-1.raku', <1 2 3 4>, -1, 'Twice Largest: 1,2,3,4  => -1';

# Task 2, Zuma Game
pwc-test './ch-2.raku', <WRRBBW RB>,      -1, 'Zuma Game: "WRRBBW",   "RB"    => -1';
pwc-test './ch-2.raku', <WWRRBBWW WRBRW>,  2, 'Zuma Game: "WWRRBBWW", "WRBRW" =>  2';
pwc-test './ch-2.raku', <G GGGGG>,         2, 'Zuma Game: "G",        "GGGGG" =>  2';
pwc-test './ch-2.raku', <ABBACCA ABC>,     2, 'Zuma Game: "ABBACCA",  "ABC"   =>  2';
