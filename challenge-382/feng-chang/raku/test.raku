#!/bin/env raku

# The Weekly Challenge 382
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

# Task 1, Hamiltonian Cycle
pwc-test './ch-1.raku', 32, '1,8,28,21,4,32,17,19,30,6,3,13,12,24,25,11,5,31,18,7,29,20,16,9,27,22,14,2,23,26,10,15',
    'Hamiltonian Cycle: 32 => 1,8,28,21,4,32,17,19,30,6,3,13,12,24,25,11,5,31,18,7,29,20,16,9,27,22,14,2,23,26,10,15';
pwc-test './ch-1.raku', 15, '', 'Hamiltonian Cycle: 15 => ""';
pwc-test './ch-1.raku', 34, '1,3,13,12,4,32,17,8,28,21,15,34,30,19,6,10,26,23,2,14,22,27,9,16,33,31,18,7,29,20,5,11,25,24',
    'Hamiltonian Cycle: 34 => 1,3,13,12,4,32,17,8,28,21,15,34,30,19,6,10,26,23,2,14,22,27,9,16,33,31,18,7,29,20,5,11,25,24';

# Task 2, Replace Question Mark
pwc-test './ch-2.raku', '01??0', '01000,01010,01100,01110',         'Replace Question Mark: 01??0 => 01000,01010,01100,01110';
pwc-test './ch-2.raku', '101',   '101',                             'Replace Question Mark: 101   => 101';
pwc-test './ch-2.raku', '???',   '000,001,010,011,100,101,110,111', 'Replace Question Mark: ???   => 000,001,010,011,100,101,110,111';
pwc-test './ch-2.raku', '1?10',  '1010,1110',                       'Replace Question Mark: 1?10  => 1010,1110';
pwc-test './ch-2.raku', '1?1?0', '10100,10110,11100,11110',         'Replace Question Mark: 1?1?0 => 10100,10110,11100,11110';
