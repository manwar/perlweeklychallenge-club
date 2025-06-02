#!/bin/env raku

# The Weekly Challenge 324
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

# Task 1, 2D Array
pwc-test './ch-1.raku', <1 2 3 4>, 2, 2, '([1, 2], [3, 4])',     '2D Array: @ints=(1,2,3,4), $r=2, $c=2 => ([1, 2], [3, 4])';
pwc-test './ch-1.raku', <1 2 3>,   1, 3, '([1, 2, 3],)',         '2D Array: @ints=(1,2,3),   $r=1, $c=3 => ([1, 2, 3])';
pwc-test './ch-1.raku', <1 2 3 4>, 4, 1, '([1], [2], [3], [4])', '2D Array: @ints=(1,2,3,4), $r=4, $c=1 => ([1], [2], [3], [4])';

# Task 2, Total XOR
pwc-test './ch-2.raku', <1 3>,           6, 'Total XOR: (1,3)         =>   6';
pwc-test './ch-2.raku', <5 1 6>,        28, 'Total XOR: (5,1,6)       =>  28';
pwc-test './ch-2.raku', <3 4 5 6 7 8>, 480, 'Total XOR: (3,4,5,6,7,8) => 480';
