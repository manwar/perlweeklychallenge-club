#!/bin/env raku

# The Weekly Challenge 298
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

# Task 1, Maximal Square
pwc-test './ch-1.raku', '[0,1],[1,0]',
    1, 'Maximal Square: [0,1],[1,0] => 1';
pwc-test './ch-1.raku', '[1,0,1,0,0],[1,0,1,1,1],[1,1,1,1,1],[1,0,0,1,0]',
    4, 'Maximal Square: [1,0,1,0,0],[1,0,1,1,1],[1,1,1,1,1],[1,0,0,1,0] => 4';
pwc-test './ch-1.raku', 0, 0, 'Maximal Square: [0] => 0';

# Task 2, Right Interval
pwc-test './ch-2.raku', '[3,4],[2,3],[1,2]', '-1 0 1',  'Right Interval: [3,4],[2,3],[1,2] => -1,0,1';
pwc-test './ch-2.raku', '[1,4],[2,3],[3,4]', '-1 2 -1', 'Right Interval: [1,4],[2,3],[3,4] => -1,2,-1';
pwc-test './ch-2.raku', '[1,2],',            '-1',      'Right Interval: [1,2]             => -1';
pwc-test './ch-2.raku', '[1,4],[2,2],[3,4]', '-1 1 -1', 'Right Interval: [1,4],[2,2],[3,4] => -1,1,-1';
