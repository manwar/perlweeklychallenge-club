#!/bin/env raku

# The Weekly Challenge 269
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

# Task 1, Bitwise OR
pwc-test './ch-1.raku', <1 2 3 4 5>, 'True',  'Bitwise OR:  (1,2,3,4,5) => True';
pwc-test './ch-1.raku', <2 3 8 16>,  'True',  'Bitwise OR:  (2,3,8,16)  => True';
pwc-test './ch-1.raku', <1 2 5 7 9>, 'False', 'Bitwise OR:  (1,2,5,7,9) => False';

# Task 2, Distribute Elements
pwc-test './ch-2.raku', <2 1 3 4 5>, '2 3 4 5 1', 'Distribute Elements: (2,1,3,4,5) => (2,3,4,5,1)';
pwc-test './ch-2.raku', <3 2 4>,     '3 4 2',     'Distribute Elements: (3,2,4)     => (3,4,2)';
pwc-test './ch-2.raku', <5 4 3 8>,   '5 3 4 8',   'Distribute Elements: (5,4,3,8)   => (5,3,4,8)';
