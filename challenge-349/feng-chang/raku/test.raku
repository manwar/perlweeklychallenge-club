#!/bin/env raku

# The Weekly Challenge 349
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

# Task 1, Power String
pwc-test './ch-1.raku', 'textbook',             2, 'Power String: textbook             => 2';
pwc-test './ch-1.raku', 'aaaaa',                5, 'Power String: aaaaa                => 5';
pwc-test './ch-1.raku', 'hoorayyy',             3, 'Power String: hoorayyy             => 3';
pwc-test './ch-1.raku', 'x',                    1, 'Power String: x                    => 1';
pwc-test './ch-1.raku', 'aabcccddeeffffghijjk', 4, 'Power String: aabcccddeeffffghijjk => 4';

# Task 2, Meeting Point
pwc-test './ch-2.raku', 'ULD',          'False', 'Meeting Point: ULD          => false';
pwc-test './ch-2.raku', 'ULDR',         'True',  'Meeting Point: ULDR         => true';
pwc-test './ch-2.raku', 'UUURRRDDD',    'False', 'Meeting Point: UUURRRDDD    => false';
pwc-test './ch-2.raku', 'UURRRDDLLL',   'True',  'Meeting Point: UURRRDDLLL   => true';
pwc-test './ch-2.raku', 'RRUULLDDRRUU', 'True',  'Meeting Point: RRUULLDDRRUU => true';
