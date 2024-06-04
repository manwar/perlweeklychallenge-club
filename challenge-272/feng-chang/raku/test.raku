#!/bin/env raku

# The Weekly Challenge 272
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

# Task 1, Defrang IP Address
pwc-test './ch-1.raku', '1.1.1.1',     '1[.]1[.]1[.]1',     'Defrang IP Address: 1.1.1.1      => 1[.]1[.]1[.]1';
pwc-test './ch-1.raku', '255.101.1.0', '255[.]101[.]1[.]0', 'Defrang IP Address: 255.101.1.0  => 255[.]101[.]1[.]0';

# Task 2, String Score
pwc-test './ch-2.raku', 'hello', 13, 'String Score: hello => 13';
pwc-test './ch-2.raku', 'perl',  30, 'String Score: perl  => 30';
pwc-test './ch-2.raku', 'raku',  37, 'String Score: raku  => 37';
