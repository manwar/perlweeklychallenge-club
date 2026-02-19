#!/bin/env raku

# The Weekly Challenge 361
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

# Task 1, Zeckendorf Representation
pwc-test './ch-1.raku', 4,   '3,1',    'Zeckendorf Representation:  4  => 3,1';
pwc-test './ch-1.raku', 12,  '8,3,1',  'Zeckendorf Representation: 12  => 8,3,1';
pwc-test './ch-1.raku', 20,  '13,5,2', 'Zeckendorf Representation: 20  => 13,5,2';
pwc-test './ch-1.raku', 96,  '89,5,2', 'Zeckendorf Representation: 96  => 89,5,2';
pwc-test './ch-1.raku', 100, '89,8,3', 'Zeckendorf Representation: 100 => 89,8,3';

# Task 2, Find Celebrity
pwc-test './ch-2.raku', '[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,0,0],[0,0,0,0,1,0]',
    4,  'Find Celebrity: [0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,1,0],[0,0,0,0,0,0],[0,0,0,0,1,0] => 4';
pwc-test './ch-2.raku', '[0,1,0,0],[0,0,1,0],[0,0,0,1],[1,0,0,0]',
    -1, 'Find Celebrity: [0,1,0,0],[0,0,1,0],[0,0,0,1],[1,0,0,0]                                             => -1';
pwc-test './ch-2.raku', '[0,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0]',
    0,  'Find Celebrity: [0,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0],[1,0,0,0,0]                         => 0';
pwc-test './ch-2.raku', '[0,1,0,1,0,1],[1,0,1,1,0,0],[0,0,0,1,1,0],[0,0,0,0,0,0],[0,1,0,1,0,0],[1,0,1,1,0,0]',
    3,  'Find Celebrity: [0,1,0,1,0,1],[1,0,1,1,0,0],[0,0,0,1,1,0],[0,0,0,0,0,0],[0,1,0,1,0,0],[1,0,1,1,0,0] => 3';
pwc-test './ch-2.raku', '[0,1,1,0],[1,0,1,0],[0,0,0,0],[0,0,0,0]',
    -1, 'Find Celebrity: [0,1,1,0],[1,0,1,0],[0,0,0,0],[0,0,0,0]                                             => -1';
pwc-test './ch-2.raku', '[0,0,1,1],[1,0,0,0],[1,1,0,1],[1,1,0,0]',
    -1, 'Find Celebrity: [0,0,1,1],[1,0,0,0],[1,1,0,1],[1,1,0,0]                                             => -1';
