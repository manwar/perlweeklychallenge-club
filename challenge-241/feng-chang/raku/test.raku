#!/bin/env raku

# The Weekly Challenge 241
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

# Task 1, Arithmetic Triplets
pwc-test './ch-1.raku', |<0 1 4 6 7 10>, 3, 2,  'Arithmetic Triplets:  @nums = (0, 1, 4, 6, 7, 10), $diff = 3 => 2';
pwc-test './ch-1.raku', |<4 5 6 7 8 9>,  2, 2,  'Arithmetic Triplets:  @nums = (4, 5, 6, 7, 8, 9),  $diff = 2 => 2';

# Task 2, Prime Order
pwc-test './ch-2.raku', |<11 8 27 4>, '11 4 8 27', 'Prime Order: (11, 8, 27, 4) => (11, 4, 8, 27)';

done-testing;
