#!/bin/env raku

# The Weekly Challenge 332
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

# Task 1, Binary Date
pwc-test './ch-1.raku', '2025-07-26', '11111101001-111-11010',  'Binary Date: 2025-07-26 => 11111101001-111-11010';
pwc-test './ch-1.raku', '2000-02-02', '11111010000-10-10',      'Binary Date: 2000-02-02 => 11111010000-10-10';
pwc-test './ch-1.raku', '2024-12-31', '11111101000-1100-11111', 'Binary Date: 2024-12-31 => 11111101000-1100-11111';

# Task 2, Odd Letters
pwc-test './ch-2.raku', 'weekly',    'False', 'Odd Letters: weekly    => false';
pwc-test './ch-2.raku', 'perl',      'True',  'Odd Letters: perl      => true';
pwc-test './ch-2.raku', 'challenge', 'False', 'Odd Letters: challenge => false';
pwc-test './ch-2.raku', 'eerie',     'True',  'Odd Letters: eerie     => true';
