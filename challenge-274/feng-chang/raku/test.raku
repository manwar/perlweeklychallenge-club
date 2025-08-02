#!/bin/env raku

# The Weekly Challenge 274
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

# Task 1, Goat Latin
pwc-test './ch-1.raku', 'I love Perl',               'Imaa ovelmaaa erlPmaaaa',
    'Goat Latin: "I love Perl"               => "Imaa ovelmaaa erlPmaaaa"';
pwc-test './ch-1.raku', 'Perl and Raku are friends', 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa',
    'Goat Latin: "Perl and Raku are friends" => "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"';
pwc-test './ch-1.raku', 'The Weekly Challenge',      'heTmaa eeklyWmaaa hallengeCmaaaa',
    'Goat Latin: "The Weekly Challenge"      => "heTmaa eeklyWmaaa hallengeCmaaaa"';

# Task 2, Bus Route
pwc-test './ch-2.raku',
    '[12,11,41],[15,5,35]',
    '36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47',
    'Bus Route: [12,11,41],[15,5,35]          => 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47';
pwc-test './ch-2.raku',
    '[12,3,41],[15,9,35],[30,5,25]',
    '0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59',
    'Bus Route: [12,3,41],[15,9,35],[30,5,25] => 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59';
