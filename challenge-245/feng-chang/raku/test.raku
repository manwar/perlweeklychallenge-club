#!/bin/env raku

# The Weekly Challenge 245
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

# Task 1, Sort Language
pwc-test './ch-1.raku',
    'perl c python',
    '2 1 3',
    'c perl python',
    'Sort Language: @lang = ("perl", "c", "python"),    @popularity = (2, 1, 3) => ("c", "perl", "python")';
pwc-test './ch-1.raku',
    'c++ haskell java',
    '1 3 2',
    'c++ java haskell',
    'Sort Language: @lang = ("c++", "haskell", "java"), @popularity = (1, 3, 2) => ("c++", "java", "haskell")';

# Task 2, Largest of Three
pwc-test './ch-2.raku', |<8 1 9>,     981,  'Largest of Three: (8, 1, 9)       =>  981';
pwc-test './ch-2.raku', |<8 6 7 1 0>, 8760, 'Largest of Three: (8, 6, 7, 1, 0) => 8760';
pwc-test './ch-2.raku', 1,            -1,   'Largest of Three: (1)             => -1';

done-testing;
