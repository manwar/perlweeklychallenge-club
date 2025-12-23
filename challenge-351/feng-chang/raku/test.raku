#!/bin/env raku

# The Weekly Challenge 351
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

# Task 1, Special Average
pwc-test './ch-1.raku', <8000 5000 6000 2000 3000 7000>,  5250, 'Special Average: 8000,5000,6000,2000,3000,7000 =>  5250';
pwc-test './ch-1.raku', <100_000 80_000 110_000 90_000>, 95000, 'Special Average: 100_000,80_000,110_000,90_000 => 95000';
pwc-test './ch-1.raku', <2500 2500 2500 2500>,               0, 'Special Average: 2500,2500,2500,2500           =>     0';
pwc-test './ch-1.raku', 2000,                                0, 'Special Average: 2000                          =>     0';
pwc-test './ch-1.raku', <1000 2000 3000 4000 5000 6000>,  3500, 'Special Average: 1000,2000,3000,4000,5000,6000 =>  3500';

# Task 2, Arithmetic Progression
pwc-test './ch-2.raku', <1 3 5 7 9>,     'True',  'Arithmetic Progression: 1,3,5,7,9     => true';
pwc-test './ch-2.raku', <9 1 7 5 3>,     'True',  'Arithmetic Progression: 9,1,7,5,3     => true';
pwc-test './ch-2.raku', <1 2 4 8 16>,    'False', 'Arithmetic Progression: 1,2,4,8,16    => false';
pwc-test './ch-2.raku', <5 -1 3 1 -3>,   'True',  'Arithmetic Progression: 5,-1,3,1,-3   => true';
pwc-test './ch-2.raku', <1.5 3 0 4.5 6>, 'True',  'Arithmetic Progression: 1.5,3,0,4.5,6 => true';
