#!/bin/env raku

# The Weekly Challenge 345
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

# Task 1, Peak Positions
pwc-test './ch-1.raku', <1 3 2>,         '1',     'Peak Positions: (1,3,2)         => 1';
pwc-test './ch-1.raku', <2 4 6 5 3>,     '2',     'Peak Positions: (2,4,6,5,3)     => 2';
pwc-test './ch-1.raku', <1 2 3 2 4 1>,   '2 4',   'Peak Positions: (1,2,3,2,4,1)   => 2,4';
pwc-test './ch-1.raku', <5 3 1>,         '0',     'Peak Positions: (5,3,1)         => 0';
pwc-test './ch-1.raku', <1 5 1 5 1 5 1>, '1 3 5', 'Peak Positions: (1,5,1,5,1,5,1) => 1,3,5';

# Task 2, Last Visitor
pwc-test './ch-2.raku', <5 -1 -1>,           '5 -1',     'Last Visitor: 5,-1,-1           => 5,-1';
pwc-test './ch-2.raku', <3 7 -1 -1 -1>,      '7 3 -1',   'Last Visitor: 3,7,-1,-1,-1      => 7,3,-1';
pwc-test './ch-2.raku', <2 -1 4 -1 -1>,      '2 4 2',    'Last Visitor: 2,-1,4,-1,-1      => 2,4,2';
pwc-test './ch-2.raku', <10 20 -1 30 -1 -1>, '20 30 20', 'Last Visitor: 10,20,-1,30,-1,-1 => 20,30,20';
pwc-test './ch-2.raku', <-- -1 -1 5 -1>,     '-1 -1 5',  'Last Visitor: -1,-1,5,-1        => -1,-1,5';
