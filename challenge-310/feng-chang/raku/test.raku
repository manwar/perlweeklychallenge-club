#!/bin/env raku

# The Weekly Challenge 310
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

# Task 1, Arrays Intersection
pwc-test './ch-1.raku', '[1,2,3,4],[4,5,6,1],[4,2,1,3]', '1,4', 'Arrays Intersection: [1,2,3,4],[4,5,6,1],[4,2,1,3] => 1,4';
pwc-test './ch-1.raku', '[1,0,2,3],[2,4,5]',             '2',   'Arrays Intersection: [1,0,2,3],[2,4,5]             => 2';
pwc-test './ch-1.raku', '[1,2,3],[4,5],[6]',             '',    'Arrays Intersection: [1,2,3],[4,5],[6]             => ""';

# Task 2, Sort Odds Evenly
pwc-test './ch-2.raku', <4 1 2 3>,   '2 3 4 1',   'Sort Odds Evenly: 4,1,2,3   => 2,3,4,1';
pwc-test './ch-2.raku', <3 1>,       '3 1',       'Sort Odds Evenly: 3,1       => 3,1';
pwc-test './ch-2.raku', <5 3 2 1 4>, '2 3 4 1 5', 'Sort Odds Evenly: 5,3,2,1,4 => 2,3,4,1,5';
