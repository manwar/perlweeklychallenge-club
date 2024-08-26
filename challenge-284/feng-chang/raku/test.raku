#!/bin/env raku

# The Weekly Challenge 284
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

# Task 1, Lucky Integer
pwc-test './ch-1.raku', <2 2 3 4>,     2, 'Lucky Integer: 2,2,3,4     => 2';
pwc-test './ch-1.raku', <1 2 2 3 3 3>, 3, 'Lucky Integer: 1,2,2,3,3,3 => 3';
pwc-test './ch-1.raku', <1 1 1 3>,    -1, 'Lucky Integer: 1,1,1,3     => -1';

# Task 2, Relative Sort
pwc-test './ch-2.raku', '2,3,9,3,1,4,6,7,2,8,5', '2,1,4,3,5,6', '2,2,1,4,3,3,5,6,7,8,9',
    'Relative Sort: 2,3,9,3,1,4,6,7,2,8,5 2,1,4,3,5,6 => 2,2,1,4,3,3,5,6,7,8,9';
pwc-test './ch-2.raku', '3,3,4,6,2,4,2,1,3',     '1,3,2',       '1,3,3,3,2,2,4,4,6',
    'Relative Sort: 3,3,4,6,2,4,2,1,3     1,3,2       => 1,3,3,3,2,2,4,4,6';
pwc-test './ch-2.raku', '3,0,5,0,2,1,4,1,1',     '1,0,3,2',     '1,1,1,0,0,3,2,4,5',
    'Relative Sort: 3,0,5,0,2,1,4,1,1     1,0,3,2     => 1,1,1,0,0,3,2,4,5';
