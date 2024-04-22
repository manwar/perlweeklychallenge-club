#!/bin/env raku

# The Weekly Challenge 266
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

# Task 1, Uncommon Words
pwc-test './ch-1.raku', 'Mango is sweet', 'Mango is sour', 'sour sweet', 'Uncommon Words: "Mango is sweet", "Mango is sour"    => "sour sweet"';
pwc-test './ch-1.raku', 'Mango Mango', 'Orange', 'Orange',               'Uncommon Words: "Mango Mongo", "Orange"              => "Orange"';
pwc-test './ch-1.raku', 'Mango is Mango', 'Orange is Orange', '',        'Uncommon Words: "Mango is Mango", "Orange is Orange" => ""';

# Task 2, X Matrix
pwc-test './ch-2.raku', '[1,0,0,2],[0,3,4,0],[0,5,6,0],[7,0,0,1]', 'True',
    "X Matrix: '[1,0,0,2],[0,3,4,0],[0,5,6,0],[7,0,0,1]' => True";
pwc-test './ch-2.raku', '[1,2,3],[4,5,6],[7,8,9]',                 'False',
    "X Matrix: '[1,2,3],[4,5,6],[7,8,9]'                 => False";
pwc-test './ch-2.raku', '[1,0,2],[0,3,0],[4,0,5]',                 'True',
    "X Matrix: '[1,0,2],[0,3,0],[4,0,5]'                 => True";
