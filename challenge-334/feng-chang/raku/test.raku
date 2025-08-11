#!/bin/env raku

# The Weekly Challenge 334
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

# Task 1, Range Sum
pwc-test './ch-1.raku', <-- -2 0 3 -5 2 -1 0 2>,  1, 'Range Sum: (-2,0,3,-5,2,-1), 0..2 =>  1';
pwc-test './ch-1.raku', <-- 1 -2 3 -4 5 1 3>,    -3, 'Range Sum: (1,-2,3,-4,5),    1..3 => -3';
pwc-test './ch-1.raku', <-- 1 0 2 -1 3 3 4>,      2, 'Range Sum: (1,0,2,-1,3),     3..4 =>  2';
pwc-test './ch-1.raku', <-- -5 4 -3 2 -1 0 0 3>, -2, 'Range Sum: (-5,4,-3,2,-1,0), 0..3 => -2';
pwc-test './ch-1.raku', <-- -1 0 2 -3 -2 1 0 2>,  1, 'Range Sum: (-1,0,2,-3,-2,1), 0..2 =>  1';

# Task 2
pwc-test './ch-2.raku', '3, 4, [1,2],[3,1],[2,4],[2,3]', 2, 'Task 2: $x=3,$y=4, @points=[1,2],[3,1],[2,4],[2,3] =>  2';
pwc-test './ch-2.raku', '2, 5, [3,4],[2,3],[1,5],[2,5]', 3, 'Task 2: $x=2,$y=5, @points=[3,4],[2,3],[1,5],[2,5] =>  3';
pwc-test './ch-2.raku', '1, 1, [2,2],[3,3],[4,4]',      -1, 'Task 2: $x=1,$y=1, @points=[2,2],[3,3],[4,4]       => -1';
pwc-test './ch-2.raku', '0, 0, [0,1],[1,0],[0,2],[2,0]', 0, 'Task 2: $x=0,$y=0, @points=[0,1],[1,0],[0,2],[2,0] =>  0';
pwc-test './ch-2.raku', '5, 5, [5,6],[6,5],[5,4],[4,5]', 0, 'Task 2: $x=5,$y=5, @points=[5,6],[6,5],[5,4],[4,5] =>  0';
