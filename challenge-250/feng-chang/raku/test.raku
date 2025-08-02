#!/bin/env raku

# The Weekly Challenge 250
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

# Task 1, Smallest Index
pwc-test './ch-1.raku', |<0 1 2>,   0, 'Smallest Index: (0, 1, 2)    => 0';
pwc-test './ch-1.raku', |<4 3 2 1>, 2, 'Smallest Index: (4, 3, 2, 1) => 2';
pwc-test './ch-1.raku', |<1 2 3 4 5 6 7 8 9 0>, -1, 'Smallest Index: (1, 2, 3, 4, 5, 6, 7, 8, 9, 0) => -1';

# Task 2, Alphanumeric String Value
pwc-test './ch-2.raku', |<perl 2 000 python r4ku>, 6, 'Alphanumeric String Value: ("perl", "2", "000", "python", "r4ku") => 6';
pwc-test './ch-2.raku', |<001 1 000 0001>,         1, 'Alphanumeric String Value: ("001", "1", "000", "0001")            => 1';

done-testing;
