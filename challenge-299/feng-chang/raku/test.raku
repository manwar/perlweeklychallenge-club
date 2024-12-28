#!/bin/env raku

# The Weekly Challenge 299
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

# Task 1, Replace Words
pwc-test './ch-1.raku',
    <cat bat rat>,
    'the cattle was rattle by the battery',
    'the cat was rat by the bat',
    'Replace Words: <cat bat rat>, "the cattle was rattle by the battery" => "the cat was rat by the bat"';
pwc-test './ch-1.raku',
    <a b c>,
    'aab aac and cac bab',
    'a a a c b',
    'Replace Words: <a b c>,       "aab aac and cac bab"                  => "a a a c b"';
pwc-test './ch-1.raku',
    <man bike>,
    'the manager was hit by a biker',
    'the man was hit by a bike',
    'Replace Words: <man bike>,    "the manager was hit by a biker"       => "the man was hit by a bike"';

# Task 2, Word Search
pwc-test './ch-2.raku', 'data-01.txt', 'True',  'Word Search: <ABDE CBCA BAAD DBBC>, BDCA  => true';
pwc-test './ch-2.raku', 'data-02.txt', 'False', 'Word Search: <AABB CCBA CAAA BBBB>, ABAC  => false';
pwc-test './ch-2.raku', 'data-03.txt', 'True',  'Word Search: <BABA CCCC ABAB BBAA>, CCCAA => true';
