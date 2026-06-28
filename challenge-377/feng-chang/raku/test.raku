#!/bin/env raku

# The Weekly Challenge 377
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

# Task 1, Reverse Existence
pwc-test './ch-1.raku', 'abcba',   'True',  'Reverse Existence: abcba   => true';
pwc-test './ch-1.raku', 'racecar', 'True',  'Reverse Existence: racecar => true';
pwc-test './ch-1.raku', 'abcd',    'False', 'Reverse Existence: abcd    => false';
pwc-test './ch-1.raku', 'banana',  'True',  'Reverse Existence: banana  => true';
pwc-test './ch-1.raku', 'hello',   'True',  'Reverse Existence: hello   => true';

# Task 2, Prefix Suffix
pwc-test './ch-2.raku', <a aba ababa aa>,  4,  'Prefix Suffix: <a aba ababa aa>  => 4';
pwc-test './ch-2.raku', <pa papa ma mama>, 2,  'Prefix Suffix: <pa papa ma mama> => 2';
pwc-test './ch-2.raku', <abao ab>,         0,  'Prefix Suffix: <abao ab>         => 0';
pwc-test './ch-2.raku', <abab abab>,       1,  'Prefix Suffix: <abab abab>       => 1';
pwc-test './ch-2.raku', <ab abab ababab>,  3,  'Prefix Suffix: <ab abab ababab>  => 3';
pwc-test './ch-2.raku', <abc def ghij>,    0,  'Prefix Suffix: <abc def ghij> a  => 0';
