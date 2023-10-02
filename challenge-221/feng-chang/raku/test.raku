#!/bin/env raku

# The Weekly Challenge 221
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Good Strings
pwc-test './ch-1.raku', |<cat bt hat tree>,       'atach',           6,
    'Good Strings: @words = ("cat", "bt", "hat", "tree"),    $chars = "atach"           =>  6';
pwc-test './ch-1.raku', |<hello world challenge>, 'welldonehopper', 10,
    'Good Strings: @words = ("hello", "world", "challenge"), $chars = "welldonehopper"  => 10';

# Task 2, Arithmetic Subsequence
pwc-test './ch-2.raku', |<9 4 7 2 10>,       3, 'Arithmetic Subsequence: (9, 4, 7, 2, 10)         => 3';
pwc-test './ch-2.raku', |<3 6 9 12>,         4, 'Arithmetic Subsequence: (3, 6, 9, 12)            => 4';
pwc-test './ch-2.raku', |<20 1 15 3 10 5 8>, 4, 'Arithmetic Subsequence: (20, 1, 15, 3, 10, 5, 8) => 4';

done-testing;
