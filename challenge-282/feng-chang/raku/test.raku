#!/bin/env raku

# The Weekly Challenge 282
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

# Task 1, Good Integer
pwc-test './ch-1.raku', 12344456, 444,   'Good Integer: 12344456 => 444';
pwc-test './ch-1.raku', 1233334,  -1,    'Good Integer: 1233334  => -1';
pwc-test './ch-1.raku', 10020003, '000', 'Good Integer: 10020003 => 000';

# Task 2, Changing Keys
pwc-test './ch-2.raku',  'pPeERrLl', 3, "Changing Keys: pPeERrLl => 3";
pwc-test './ch-2.raku',  'rRr',      0, "Changing Keys: rRr      => 0";
pwc-test './ch-2.raku',  'GoO',      1, "Changing Keys: GoO      => 1";
pwc-test './ch-2a.raku', 'pPeERrLl', 3, "Changing Keys: pPeERrLl => 3";
pwc-test './ch-2a.raku', 'rRr',      0, "Changing Keys: rRr      => 0";
pwc-test './ch-2a.raku', 'GoO',      1, "Changing Keys: GoO      => 1";
