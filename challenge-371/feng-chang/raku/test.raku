#!/bin/env raku

# The Weekly Challenge 371
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

# Task 1, Missing Letter
pwc-test './ch-1.raku', <a c ? g i>, 'e', 'Missing Letter: a c ? g i => e';
pwc-test './ch-1.raku', <a d ? j m>, 'g', 'Missing Letter: a d ? j m => g';
pwc-test './ch-1.raku', <a e ? m q>, 'i', 'Missing Letter: a e ? m q => i';
pwc-test './ch-1.raku', <a c f ? k>, 'h', 'Missing Letter: a c f ? k => h';
pwc-test './ch-1.raku', <b e g ? l>, 'j', 'Missing Letter: b e g ? l => j';

# Task 2, Subset Equilibrium
pwc-test './ch-2.raku', <2 1 4 3>,     '((2 1) (2 3) (1 4) (4 3))', 'Subset Equilibrium: 2,1,4,3     => (2, 1), (2, 3), (1, 4), (4, 3)';
pwc-test './ch-2.raku', <3 0 3 0>,     '((3 0) (3 0 3))',           'Subset Equilibrium: 3,0,3,0     => (3, 0), (3, 0, 3)';
pwc-test './ch-2.raku', <5 1 1 1>,     '((5 1 1))',                 'Subset Equilibrium: 5,1,1,1     => (5, 1, 1)';
pwc-test './ch-2.raku', <3 -1 4 2>,    '((3 2) (3 -1 4))',          'Subset Equilibrium: 3,-1,4,2    => (3, 2), (3, -1, 4)';
pwc-test './ch-2.raku', <10 20 30 40>, '()',                        'Subset Equilibrium: 10,20,30,40 => ()';
