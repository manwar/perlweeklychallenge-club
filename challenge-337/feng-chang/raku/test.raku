#!/bin/env raku

# The Weekly Challenge 337
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

# Task 1, Smaller Than Current
pwc-test './ch-1.raku', <6 5 4 8>,        '2 1 0 3',   'Smaller Than Current: (6,5,4,8)     => (2,1,0,3)';
pwc-test './ch-1.raku', <7 7 7 7>,        '0 0 0 0',   'Smaller Than Current: (7,7,7,7)     => (0,0,0,0)';
pwc-test './ch-1.raku', <5 4 3 2 1>,      '4 3 2 1 0', 'Smaller Than Current: (5,4,3,2,1)   => (4,3,2,1,0)';
pwc-test './ch-1.raku', <-- -1 0 3 -2 1>, '1 2 4 0 3', 'Smaller Than Current: (-1,0,3,-2,1) => (1,2,4,0,3)';
pwc-test './ch-1.raku', <0 1 1 2 0>,      '0 2 2 4 0', 'Smaller Than Current: (0,1,1,2,0)   => (0,2,2,4,0)';

# Task 2, Odd Matrix
pwc-test './ch-2.raku', <2 3 [0,1],[1,1]>,             6, 'Odd Matrix: $row=2, $col=3, @locations=([0,1],[1,1])             => 6';
pwc-test './ch-2.raku', <2 2 [1,1],[0,0]>,             0, 'Odd Matrix: $row=2, $col=2, @locations=([1,1],[0,0])             => 0';
pwc-test './ch-2.raku', <3 3 [0,0],[1,2],[2,1]>,       0, 'Odd Matrix: $row=3, $col=3, @locations=([0,0],[1,2],[2,1])       => 0';
pwc-test './ch-2.raku', <1 5 [0,2],[0,4]>,             2, 'Odd Matrix: $row=1, $col=5, @locations=([0,2],[0,4])             => 2';
pwc-test './ch-2.raku', <4 2 [1,0],[3,1],[2,0],[0,1]>, 8, 'Odd Matrix: $row=4, $col=2, @locations=([1,0],[3,1],[2,0],[0,1]) => 8';
