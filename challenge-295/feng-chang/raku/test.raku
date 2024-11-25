#!/bin/env raku

# The Weekly Challenge 295
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

# Task 1, Word Break
pwc-test './ch-1.raku', <weeklychallenge challenge weekly>,     'True',  'Word Break: weeklychallenge challenge weekly     => true';
pwc-test './ch-1.raku', <perlrakuperl raku perl>,               'True',  'Word Break: perlrakuperl raku perl               => true';
pwc-test './ch-1.raku', <sonsanddaughters sons sand daughters>, 'False', 'Word Break: sonsanddaughters sons sand daughters => false';
pwc-test './ch-1.raku', <sonsanddaughters sons and daughters>,  'True',  'Word Break: sonsanddaughters sons and daughters  => true';

# Task 2, Jump Game
pwc-test './ch-2.raku', <2 3 1 1 4>, 2, 'Jump Game: 2,3,1,1,4 => 2';
pwc-test './ch-2.raku', <2 3 0 4>,   2, 'Jump Game: 2,3,0,4   => 2';
pwc-test './ch-2.raku', <2 0 0 4>,  -1, 'Jump Game: 2,0,0,4   => -1';
