#!/bin/env raku

# The Weekly Challenge 234
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

# Task 1, Common Characters
pwc-test :deeply,
    './ch-1.raku', |<java javascript julia>,
    'j a'.words.Bag,
    'Common Characters: ("java", "javascript", "julia") => "j a"';
pwc-test :deeply,
    './ch-1.raku', |<bella label roller>,
    'e l l'.words.Bag,
    'Common Characters: ("bella", "label", "roller")    => "e l l"';
pwc-test :deeply,
    './ch-1.raku', |<cool lock cook>,
    'c o'.words.Bag,
    'Common Characters: ("cool", "lock", "cook")        => "c o"';

# Task 2, Unequal Triplets
    pwc-test './ch-2.raku', |<4 4 2 4 3>,        3,  'Unequal Triplets: 4, 4, 2, 4, 3           => 3';
    pwc-test './ch-2.raku', |<1 1 1 1 1>,        0,  'Unequal Triplets: 1, 1, 1, 1, 1           => 0';
    pwc-test './ch-2.raku', |<4 7 1 10 7 4 1 1>, 28, 'Unequal Triplets: 4, 7, 1, 10, 7, 4, 1, 1 => 28';

done-testing;
