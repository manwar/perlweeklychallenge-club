#!/bin/env raku

# The Weekly Challenge 374
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

# Task 1, Count Vowel
pwc-test './ch-1.raku', 'aeiou',         '(aeiou)',                                       'Count Vowel: aeiou         => (aeiou)';
pwc-test './ch-1.raku', 'aaeeeiioouu',   '(aaeeeiioou aaeeeiioouu aeeeiioou aeeeiioouu)', 'Count Vowel: aaeeeiioouu   => (aaeeeiioou aaeeeiioouu aeeeiioou aeeeiioouu)';
pwc-test './ch-1.raku', 'aeiouuaxaeiou', '(aeiou aeiouu aeiouua eiouua aeiou)',           'Count Vowel: aeiouuaxaeiou => (aeiou aeiouu aeiouua eiouua aeiou)';
pwc-test './ch-1.raku', 'uaeiou',        '(uaeio uaeiou aeiou)',                          'Count Vowel: uaeiou        => (uaeio uaeiou aeiou)';
pwc-test './ch-1.raku', 'aeioaeioa',     '()',                                            'Count Vowel: aeioaeioa     => ()';

# Task 2, Largest Same-digits Number
pwc-test './ch-2.raku', 6777133339, 3333,  'Largest Same-digits Number: 6777133339 => 3333';
pwc-test './ch-2.raku', 1200034,    4,     'Largest Same-digits Number: 1200034    => 4';
pwc-test './ch-2.raku', 44221155,   55,    'Largest Same-digits Number: 44221155   => 55';
pwc-test './ch-2.raku', 88888,      88888, 'Largest Same-digits Number: 88888      => 88888';
pwc-test './ch-2.raku', 11122233,   222,   'Largest Same-digits Number: 11122233   => 222';
