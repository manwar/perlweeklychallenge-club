#!/bin/env raku

# The Weekly Challenge 265
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

# Task 1, 33% Appearance
pwc-test './ch-1.raku', <1 2 3 3 3 3 4 2>, 3, '33% Appearance: (1,2,3,3,3,3,4,2) => 3';
pwc-test './ch-1.raku', <1 1>,             1, '33% Appearance: (1,1)             => 1';
pwc-test './ch-1.raku', <1 2 3>,           1, '33% Appearance: (1,2,3)           => 1';

# Task 2, Completing Word
pwc-test './ch-2.raku', 'aBc 11c', <accbbb abc abbc>, 'accbbb',
    "Completing Word: \$str = 'aBc 11c', \@str = ('accbbb','abc','abbc')     => accbbb";
pwc-test './ch-2.raku', 'Da2 abc', <abcm baacd abaadc>, 'baacd',
    "Completing Word: \$str = 'Da2 abc', \@str = ('abcm', 'baacd', 'abaadc') => baacd";
pwc-test './ch-2.raku', 'JB 007', <jj bb bjb>, 'bjb',
    "Completing Word: \$str = 'JB 007',  \@str = ('jj', 'bb', 'bjb')         => bjb";
