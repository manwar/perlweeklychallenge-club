#!/bin/env raku

# The Weekly Challenge 267
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

# Task 1, Product Sign
pwc-test './ch-1.raku', '--', <-1 -2 -3 -4 3 2 1>, 1, 'Product Sign: (-1, -2, -3, -4, 3, 2, 1) =>  1';
pwc-test './ch-1.raku', '--', <1 2 0 -2 -1>,       0, 'Product Sign: (1, 2, 0, -2, -1)         =>  0';
pwc-test './ch-1.raku', '--', <-1 -1 1 -1 2>,     -1, 'Product Sign: (-1, -1, 1, -1, 2)        => -1';

pwc-test './ch-1a.raku', '--', <-1 -2 -3 -4 3 2 1>, 1, 'Product Sign: (-1, -2, -3, -4, 3, 2, 1) =>  1';
pwc-test './ch-1a.raku', '--', <1 2 0 -2 -1>,       0, 'Product Sign: (1, 2, 0, -2, -1)         =>  0';
pwc-test './ch-1a.raku', '--', <-1 -1 1 -1 2>,     -1, 'Product Sign: (-1, -1, 1, -1, 2)        => -1';

# Task 2, Line Counts
pwc-test './ch-2.raku', 'abcdefghijklmnopqrstuvwxyz', 10 xx 26, '(3, 60)',
    '$str = "abcdefghijklmnopqrstuvwxyz", @widths = (10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10) => (3,26)';
pwc-test './ch-2.raku', 'bbbcccdddaaa', 4, 10 xx 25, '(2, 4)',
    '$str = "bbbcccdddaaa",               @widths = (4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)  => (2,4)',
