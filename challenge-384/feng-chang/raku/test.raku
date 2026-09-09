#!/bin/env raku

# The Weekly Challenge 384
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

# Task 1, Base N
pwc-test './ch-1.raku', 42,         2, '101010', 'Base N: $num=42,       $base=2  => 101010';
pwc-test './ch-1.raku', 15642094,  16, 'EEADEE', 'Base N: $num=15642094, $base=16 => EEADEE';
pwc-test './ch-1.raku', 493,        8, '755',    'Base N: $num=493,      $base=8  => 755';
pwc-test './ch-1.raku', 2228519,   36, '1BRJB',  'Base N: $num=2228519,  $base=36 => 1BRJB';
pwc-test './ch-1.raku', 123456789, 64, '7MyqL',  'Base N: $num=123456789,$base=64 => 7MyqL';

# Task 2, Special Binary Substrings
pwc-test './ch-2.raku', '0101',     '01 10',           'Special Binary Substrings: 0101     => 01 10';
pwc-test './ch-2.raku', '000111',   '000111 0011 01',  'Special Binary Substrings: 000111   => 000111 0011 01';
pwc-test './ch-2.raku', '000011',   '0011 01',         'Special Binary Substrings: 000111   => 0011 01';
pwc-test './ch-2.raku', '10011100', '10 0011 01 1100', 'Special Binary Substrings: 10011100 => 10 0011 01 1100';
pwc-test './ch-2.raku', '00000',    '',                'Special Binary Substrings: 00000    => ""';
