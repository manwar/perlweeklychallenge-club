#!/bin/env raku

# The Weekly Challenge 236
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

# Task 1, Seize The Day
pwc-test './ch-1.raku', |<2024 4 3 2>,  16, 'Seize The Day: (2024, 4, 3, 2)  => 16';
pwc-test './ch-1.raku', |<2025 10 2 4>, 9,  'Seize The Day: (2025, 10, 2, 4) => 9';
pwc-test './ch-1.raku', |<2026 8 5 3>,  0,  'Seize The Day: (2026, 8, 5, 3)  => 0';

pwc-test './ch-1a.raku', |<2024 4 3 2>,  16, 'Seize The Day: (2024, 4, 3, 2)  => 16';
pwc-test './ch-1a.raku', |<2025 10 2 4>, 9,  'Seize The Day: (2025, 10, 2, 4) => 9';
pwc-test './ch-1a.raku', |<2026 8 5 3>,  0,  'Seize The Day: (2026, 8, 5, 3)  => 0';

# Task 2, Maximise Greatness
pwc-test './ch-2.raku', |<1 3 5 2 1 3 1>, 4, 'Maximise Greatness: (1, 3, 5, 2, 1, 3, 1) => 4';
pwc-test './ch-2.raku', |<1 2 3 4>,       3, 'Maximise Greatness: (1, 2, 3, 4)          => 3';

done-testing;
